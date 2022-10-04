#' Prep Data for C5.0 - Recipe
#'
#' @family Preprocessor
#' @family C5.0
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details This function will automatically prep your data.frame/tibble for
#' use in the C5.0 algorithm. The C5.0 algorithm is a lazy learning classification
#' algorithm. It expects data to be presented in a certain fashion.
#'
#' This function will output a recipe specification.
#'
#' @description Automatically prep a data.frame/tibble for use in the C5.0 algorithm.
#'
#' @seealso \url{https://www.rulequest.com/see5-unix.html}
#'
#' @param .data The data that you are passing to the function. Can be any type
#' of data that is accepted by the `data` parameter of the `recipes::recipe()`
#' function.
#' @param .recipe_formula The formula that is going to be passed. For example
#' if you are using the `iris` data then the formula would most likely be something
#' like `Species ~ .`
#'
#' @examples
#' library(ggplot2)
#'
#' hai_c50_data_prepper(.data = Titanic, .recipe_formula = Survived ~ .)
#' rec_obj <- hai_c50_data_prepper(Titanic, Survived ~ .)
#' get_juiced_data(rec_obj)
#'
#' @return
#' A recipe object
#'
#' @export
#'

hai_c50_data_prepper <- function(.data, .recipe_formula) {

  # Recipe ---
  rec_obj <- recipes::recipe(.recipe_formula, data = .data) %>%
    recipes::step_string2factor(tidyselect::vars_select_helpers$where(is.character))

  # Return ----
  return(rec_obj)
}
