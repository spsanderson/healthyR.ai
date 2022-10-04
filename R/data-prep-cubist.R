#' Prep Data for Cubist - Recipe
#'
#' @family Preprocessor
#' @family cubist
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details This function will automatically prep your data.frame/tibble for
#' use in the cubist algorithm. The cubist algorithm is for regression only.
#'
#' This function will output a recipe specification.
#'
#' @description Automatically prep a data.frame/tibble for use in the cubist algorithm.
#'
#' @seealso \url{https://rulequest.com/cubist-info.html}
#'
#' @param .data The data that you are passing to the function. Can be any type
#' of data that is accepted by the `data` parameter of the `recipes::reciep()`
#' function.
#' @param .recipe_formula The formula that is going to be passed. For example
#' if you are using the `diamonds` data then the formula would most likely be something
#' like `price ~ .`
#'
#' @examples
#' library(ggplot2)
#'
#' hai_cubist_data_prepper(.data = diamonds, .recipe_formula = price ~ .)
#' rec_obj <- hai_cubist_data_prepper(diamonds, price ~ .)
#' get_juiced_data(rec_obj)
#'
#' @return
#' A recipe object
#'
#' @export
#'

hai_cubist_data_prepper <- function(.data, .recipe_formula) {

  # Recipe ---
  rec_obj <- recipes::recipe(.recipe_formula, data = .data) %>%
    recipes::step_zv(recipes::all_predictors())

  # Return ----
  return(rec_obj)
}
