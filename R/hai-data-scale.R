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
#' @param .range_max A single numeric value for the largeest value in the range.
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
#' val_seq  <- rep(rnorm(10, mean = 6, sd = 2), times = 10)
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

hai_data_scale <-  function(.recipe_object = NULL, ...,
                            .type_of_imputation = "mean", .range_min, .range_max,
                            .scale_factor){

}
