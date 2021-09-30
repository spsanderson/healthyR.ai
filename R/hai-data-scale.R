#' Data Preprocessor - Scale/Normalize
#'
#' @family Scale Normalize
#' @family Data Recipes
#' @family Preprocessor
#'
#' @keywords internal
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @description
#' Takes in a recipe and will impute missing values using a selected recipe.
#' To call the recipe use a quoted argument like "median" or "bagged". This function
#' is not exported but may be called via the ::: method.
#'
#' @details
#' This function will get your data ready for processing with many types of ml/ai
#' models.
#'
#' This is intended to be used inside of the [healthyR.ai::hai_data_preprocessor()] and
#' therefore is an internal function. This documentation exists to explain the process
#' and help the user understand the parameters that can be set in the preprocessor function.
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
#' @seealso  \url{https://recipes.tidymodels.org/reference/step_impute_linear.html}
#'
#' step_impute_lower
#'
#' [recipes::step_impute_lower()]
#' @seealso \url{https://recipes.tidymodels.org/reference/step_impute_lower.html}
#'
#' @param .recipe_object The data that you want to process
#' @param ... One or more selector functions to choose variables to be imputed.
#' When used with imp_vars, these dots indicate which variables are used to
#' predict the missing data in each variable. See selections() for more details
#' @param .type_of_scale This is a quoted argument and can be one of the following:
#' -  "center"
#' -  "normalize"
#' -  "range"
#' -  "scale"
#'
#' @examples
#' suppressPackageStartupMessages(library(dplyr))
#' suppressPackageStartupMessages(library(recipes))
#'
#' date_seq <- seq.Date(from = as.Date("2013-01-01"), length.out = 100, by = "month")
#' val_seq  <- rep(c(rnorm(9), NA), times = 10)
#' df_tbl   <- tibble(
#'     date_col = date_seq,
#'     value    = val_seq
#' )
#'
#' rec_obj <- recipe(value ~., df_tbl)
#'
#' hai_data_impute(
#'     .recipe_object = rec_obj,
#'     value,
#'     .type_of_imputation = "roll"
#' ) %>%
#'     get_juiced_data()
#'
#' @return
#' A list object
#'
