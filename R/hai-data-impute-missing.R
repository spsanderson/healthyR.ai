#' Data Preprocessor - Imputation
#'
#' @family Data Recipes
#' @family Preprocessor
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @description
#' Takes in a recipe and will impute missing values using a selected recipe.
#' To call the recipe use a quoted argument like "median" or "bagged".
#'
#' @details
#' This function will get your data ready for processing with many types of ml/ai
#' models.
#'
#' This is intended to be used inside of the data processor and
#' therefore is an internal function. This documentation exists to explain the process
#' and help the user understand the parameters that can be set in the pre-processor function.
#'
#' @seealso \url{https://recipes.tidymodels.org/reference/index.html#section-step-functions-imputation/}
#'
#' step_impute_bag
#'
#' [recipes::step_impute_bag()]
#' @seealso \url{https://recipes.tidymodels.org/reference/step_impute_bag.html}
#'
#' step_impute_knn
#'
#' [recipes::step_impute_knn()]
#' @seealso \url{https://recipes.tidymodels.org/reference/step_impute_knn.html}
#'
#' step_impute_linear
#'
#' [recipes::step_impute_linear()]
#' @seealso \url{https://recipes.tidymodels.org/reference/step_impute_linear.html}
#'
#' step_impute_lower
#'
#' [recipes::step_impute_lower()]
#' @seealso \url{https://recipes.tidymodels.org/reference/step_impute_lower.html}
#'
#' step_impute_mean
#'
#' [recipes::step_impute_mean()]
#' @seealso \url{https://recipes.tidymodels.org/reference/step_impute_mean.html}
#'
#' step_impute_median
#'
#' [recipes::step_impute_median()]
#' @seealso \url{https://recipes.tidymodels.org/reference/step_impute_median.html}
#'
#' step_impute_mode
#'
#' [recipes::step_impute_mode()]
#' @seealso \url{https://recipes.tidymodels.org/reference/step_impute_mode.html}
#'
#' step_impute_roll
#'
#' [recipes::step_impute_roll()]
#' @seealso \url{https://recipes.tidymodels.org/reference/step_impute_roll.html}
#'
#' @param .recipe_object The data that you want to process
#' @param ... One or more selector functions to choose variables to be imputed.
#' When used with imp_vars, these dots indicate which variables are used to
#' predict the missing data in each variable. See selections() for more details
#' @param .seed_value To make results reproducible, set the seed.
#' @param .number_of_trees This is used for the [recipes::step_impute_bag()] trees
#' parameter. This should be an integer.
#' @param .type_of_imputation This is a quoted argument and can be one of the following:
#' -  "bagged"
#' -  "knn"
#' -  "linear"
#' -  "lower"
#' -  "mean"
#' -  "median"
#' -  "mode"
#' -  "roll"
#' @param .neighbors This should be filled in with an integer value if `.type_of_imputation`
#' selected is "knn".
#' @param .mean_trim This should be filled in with a fraction if `.type_of_imputation`
#' selected is "mean".
#' @param .roll_statistic This should be filled in with a single unquoted function
#' that takes with it a single argument such as mean. This should be filled in
#' if `.type_of_imputation` selected is "roll".
#' @param .roll_window This should be filled in with an integer value if `.type_of_imputation`
#' selected is "roll".
#'
#' @examples
#' suppressPackageStartupMessages(library(dplyr))
#' suppressPackageStartupMessages(library(recipes))
#'
#' date_seq <- seq.Date(from = as.Date("2013-01-01"), length.out = 100, by = "month")
#' val_seq <- rep(c(rnorm(9), NA), times = 10)
#' df_tbl <- tibble(
#'   date_col = date_seq,
#'   value    = val_seq
#' )
#'
#' rec_obj <- recipe(value ~ ., df_tbl)
#'
#' hai_data_impute(
#'   .recipe_object = rec_obj,
#'   value,
#'   .type_of_imputation = "roll",
#'   .roll_statistic = median
#' )$impute_rec_obj %>%
#'   get_juiced_data()
#'
#' @return
#' A list object
#'
#' @export
#'

hai_data_impute <- function(.recipe_object = NULL, ...,
                            .seed_value = 123, .type_of_imputation = "mean",
                            .number_of_trees = 25, .neighbors = 5, .mean_trim = 0,
                            .roll_statistic, .roll_window = 5) {

  # Make sure a recipe was passed
  if (is.null(.recipe_object)) {
    rlang::abort("`.recipe_object` must be passed, please add.")
  } else {
    rec_obj <- .recipe_object
  }

  # * Parameters ----
  terms <- rlang::enquos(...)
  # impute_with <- .impute_vars_with
  seed_value <- as.integer(.seed_value)
  impute_type <- as.character(.type_of_imputation)
  trees <- as.integer(.number_of_trees)
  neighbors <- as.integer(.neighbors)
  mean_trim <- as.numeric(.mean_trim) # 1 >= trim >= 0
  roll_stat <- .roll_statistic
  roll_window <- as.integer(.roll_window)

  # * Checks ----
  # if (is.null(impute_with)) {
  #     rlang::abort("`impute_with` Needs some variables please.")
  # }

  if ((!is.null(seed_value) & !is.numeric(seed_value))) {
    stop(call. = FALSE, "(.seed_value) must either be NULL or an integer.")
  }

  if (!is.character(impute_type)) {
    stop(call. = FALSE, "(.type_of_imputation) must be a quoted function that takes a single
             parameter, i.e. mean or median.")
  }

  if (!tolower(impute_type) %in% c(
    "bagged", "knn", "linear", "lower", "mean", "median", "mode", "roll"
  )
  ) {
    stop(call. = FALSE, "(.type_of_imputattion) is not implemented. Please choose
             from 'bagged','knn','linear','lower','mean','median','mode','roll'")
  }

  if (!is.numeric(trees) | !is.numeric(neighbors) | !is.numeric(roll_window)) {
    stop(call. = FALSE, "The parameters of (.trees), (.neighbors), and (.roll_window) must
             be integers.")
  }

  if (!is.numeric(mean_trim) | (mean_trim > 1) | (mean_trim < 0)) {
    stop(call. = FALSE, "(.mean_trim) must be a fraction between 0 and 1, such as 0.25")
  }

  # Is the .recipe_object in fact a class of recipe?
  if (!inherits(x = rec_obj, what = "recipe")) {
    stop(call. = FALSE, "You must supply an object of class recipe.")
  }

  # * if statement to run the desired type of imputation
  if (impute_type == "bagged") {
    imp_obj <- recipes::step_impute_bag(
      recipe      = rec_obj,
      !!!terms,
      # impute_with = impute_with,
      trees       = trees,
      seed_val    = seed_value
    )
  } else if (impute_type == "knn") {
    imp_obj <- recipes::step_impute_knn(
      recipe      = rec_obj,
      !!!terms,
      # impute_with = impute_with,
      neighbors   = neighbors
    )
  } else if (impute_type == "linear") {
    imp_obj <- recipes::step_impute_linear(
      recipe      = rec_obj,
      !!!terms,
      # impute_with = impute_with
    )
  } else if (impute_type == "lower") {
    imp_obj <- recipes::step_impute_lower(
      recipe = rec_obj,
      !!!terms
    )
  } else if (impute_type == "mean") {
    imp_obj <- recipes::step_impute_mean(
      recipe = rec_obj,
      !!!terms,
      trim   = mean_trim
    )
  } else if (impute_type == "median") {
    imp_obj <- recipes::step_impute_median(
      recipe = rec_obj,
      !!!terms
    )
  } else if (impute_type == "mode") {
    imp_obj <- recipes::step_impute_mode(
      recipe = rec_obj,
      !!!terms
    )
  } else if (impute_type == "roll") {
    imp_obj <- recipes::step_impute_roll(
      recipe    = rec_obj,
      !!!terms,
      statistic = roll_stat,
      window    = roll_window
    )
  }

  # * Recipe List ---
  output <- list(
    rec_base       = rec_obj,
    impute_rec_obj = imp_obj
  )

  # * Return ----
  return(output)
}
