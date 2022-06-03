#' Prep Data for SVM_Poly - Recipe
#'
#' @family Preprocessor
#' @family SVM_Poly
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details This function will automatically prep your data.frame/tibble for
#' use in the SVM_Poly algorithm. The SVM_Poly algorithm is for regression only.
#'
#' This function will output a recipe specification.
#'
#' @description Automatically prep a data.frame/tibble for use in the SVM_Poly algorithm.
#'
#' @seealso \url{https://parsnip.tidymodels.org/reference/svm_poly.html}
#'
#' @param .data The data that you are passing to the function. Can be any type
#' of data that is accepted by the `data` parameter of the `recipes::reciep()`
#' function.
#' @param .recipe_formula The formula that is going to be passed. For example
#' if you are using the `diamonds` data then the formula would most likely be something
#' like `price ~ .`
#'
#' @examples
#' # Regression
#' hai_svm_poly_data_prepper(.data = diamonds, .recipe_formula = price ~ .)
#' reg_obj <- hai_svm_poly_data_prepper(diamonds, price ~ .)
#' get_juiced_data(reg_obj)
#'
#' # Classification
#' hai_svm_poly_data_prepper(Titanic, Survived ~ .)
#' cla_obj <- hai_svm_poly_data_prepper(Titanic, Survived ~ .)
#' get_juiced_data(cla_obj)
#'
#' @return
#' A recipe object
#'
#' @export
#'

hai_svm_poly_data_prepper <- function(.data, .recipe_formula){

    # Recipe ---
    rec_obj <- recipes::recipe(.recipe_formula, data = .data) %>%
        recipes::step_zv(recipes::all_predictors()) %>%
        recipes::step_normalize(recipes::all_numeric_predictors())

    # Return ----
    return(rec_obj)

}
