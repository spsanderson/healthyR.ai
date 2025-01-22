#' Prep Data for XGBoost - Recipe
#'
#' @family Preprocessor
#' @family XBGoost
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details This function will automatically prep your data.frame/tibble for
#' use in the XGBoost algorithm.
#'
#' This function will output a recipe specification.
#'
#' @description Automatically prep a data.frame/tibble for use in the xgboost algorithm.
#'
#' @seealso \url{https://parsnip.tidymodels.org/reference/details_boost_tree_xgboost.html}
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
#' # Regression
#' hai_xgboost_data_prepper(.data = diamonds, .recipe_formula = price ~ .)
#' reg_obj <- hai_xgboost_data_prepper(diamonds, price ~ .)
#' get_juiced_data(reg_obj)
#'
#' # Classification
#' Titanic <- as_tibble(Titanic)
#' 
#' hai_xgboost_data_prepper(Titanic, Survived ~ .)
#' cla_obj <- hai_xgboost_data_prepper(Titanic, Survived ~ .)
#' get_juiced_data(cla_obj)
#'
#' @return
#' A recipe object
#'
#' @export
#'

hai_xgboost_data_prepper <- function(.data, .recipe_formula) {

  # Recipe ---
  rec_obj <- recipes::recipe(.recipe_formula, data = .data) %>%
    recipes::step_string2factor(tidyselect::vars_select_helpers$where(is.character)) %>%
    recipes::step_novel(recipes::all_nominal_predictors()) %>%
    recipes::step_dummy(recipes::all_nominal_predictors()) %>%
    recipes::step_zv(recipes::all_predictors())

  # Return ----
  return(rec_obj)
}
