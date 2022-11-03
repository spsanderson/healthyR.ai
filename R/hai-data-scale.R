#' Data Preprocessor - Scale/Normalize
#'
#' @family Data Recipes
#' @family Preprocessor
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @description
#' Takes in a recipe and will scale values using a selected recipe. To call the
#' recipe use a quoted argument like "scale" or "normalize".
#'
#' @details
#' This function will get your data ready for processing with many types of ml/ai
#' models.
#'
#' This is intended to be used inside of the data processor and
#' therefore is an internal function. This documentation exists to explain the process
#' and help the user understand the parameters that can be set in the pre-processor function.
#'
#' @seealso \url{https://recipes.tidymodels.org/reference/index.html#section-step-functions-normalization}
#'
#' step_center
#'
#' [recipes::step_center()]
#' @seealso \url{https://recipes.tidymodels.org/reference/step_center.html}
#'
#' step_normalize
#'
#' [recipes::step_normalize()]
#' @seealso \url{https://recipes.tidymodels.org/reference/step_normalize.html}
#'
#' step_range
#'
#' [recipes::step_range()]
#' @seealso \url{https://recipes.tidymodels.org/reference/step_range.html}
#'
#' step_scale
#'
#' [recipes::step_scale()]
#' @seealso \url{https://recipes.tidymodels.org/reference/step_scale.html}
#'
#' @references Gelman, A. (2007) "Scaling regression inputs by
#'  dividing by two standard deviations." Unpublished. Source:
#'  \url{http://www.stat.columbia.edu/~gelman/research/unpublished/standardizing.pdf}.
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
#' @param .range_min A single numeric value for the smallest value in the range.
#' This defaults to 0.
#' @param .range_max A single numeric value for the largeest value in the range.
#' This defaults to 1.
#' @param .scale_factor A numeric value of either 1 or 2 that scales the numeric
#' inputs by one or two standard deviations. By dividing by two standard
#' deviations, the coefficients attached to continuous predictors can be
#' interpreted the same way as with binary inputs. Defaults to 1. More in reference below.
#'
#' @examples
#' suppressPackageStartupMessages(library(dplyr))
#' suppressPackageStartupMessages(library(recipes))
#'
#' date_seq <- seq.Date(from = as.Date("2013-01-01"), length.out = 100, by = "month")
#' val_seq <- rep(rnorm(10, mean = 6, sd = 2), times = 10)
#' df_tbl <- tibble(
#'   date_col = date_seq,
#'   value    = val_seq
#' )
#'
#' rec_obj <- recipe(value ~ ., df_tbl)
#'
#' hai_data_scale(
#'   .recipe_object = rec_obj,
#'   value,
#'   .type_of_scale = "center"
#' )$scale_rec_obj %>%
#'   get_juiced_data()
#'
#' @return
#' A list object
#'
#' @export
#'

hai_data_scale <- function(.recipe_object = NULL, ...,
                           .type_of_scale = "center", .range_min = 0,
                           .range_max = 1, .scale_factor = 1) {

  # Make sure a recipe was passed
  if (is.null(.recipe_object)) {
    rlang::abort("`.recipe_object` must be passed, please add.")
  } else {
    rec_obj <- .recipe_object
  }

  # * Parameters ----
  terms <- rlang::enquos(...)
  scale_type <- as.character(.type_of_scale)
  range_min <- as.numeric(.range_min)
  range_max <- as.numeric(.range_max)
  scale_factor <- as.numeric(.scale_factor)

  # * Checks ----
  if (!is.null(range_min) & !is.numeric(range_min)) {
    stop(call. = FALSE, "(.range_min) must be numeric.")
  }

  if (!is.null(range_max) & !is.numeric(range_max)) {
    stop(call. = FALSE, "(.range_max) must be numeric.")
  }
  if (!is.null(scale_factor) & !is.numeric(scale_factor)) {
    stop(call. = FALSE, "(.scale_factor) must be numeric.")
  }

  if (!tolower(scale_type) %in% c(
    "center", "normalize", "range", "scale"
  )
  ) {
    stop(call. = FALSE, "(.type_of_scale) is not implemented. Please choose
             from 'center','normalize','range','scale'")
  }

  # If Statment to get the recipe desired ----
  if (scale_type == "center") {
    scale_obj <- recipes::step_center(
      recipe = rec_obj,
      !!!terms
    )
  } else if (scale_type == "normalize") {
    scale_obj <- recipes::step_normalize(
      recipe = rec_obj,
      !!!terms
    )
  } else if (scale_type == "range") {
    scale_obj <- recipes::step_range(
      recipe = rec_obj,
      !!!terms,
      min = range_min,
      max = range_max
    )
  } else if (scale_type == "scale") {
    scale_obj <- recipes::step_scale(
      recipe = rec_obj,
      !!!terms,
      factor = scale_factor
    )
  }

  # * Recipe List ---
  output <- list(
    rec_base      = rec_obj,
    scale_rec_obj = scale_obj
  )

  # * Return ----
  return(output)
}
