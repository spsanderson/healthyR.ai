#' Prep Data for k-NN - Recipe
#'
#' @family Preprocessor
#' @family knn
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details This function will automatically prep your data.frame/tibble for
#' use in the k-NN algorithm. The k-NN algorithm is a lazy learning classification
#' algorithm. It expects data to be presented in a certain fashion.
#'
#' This function will output a recipe specification.
#'
#' @description Automatically prep a data.frame/tibble for use in the k-NN algorithm.
#'
#' @param .data The data that you are passing to the function. Can be any type
#' of data that is accepted by the `data` parameter of the `recipes::reciep()`
#' function.
#' @param .recipe_formula The formula that is going to be passed. For example
#' if you are using the `iris` data then the formula would most likely be something
#' like `Species ~ .`
#'
#' @examples
#' hai_knn_data_prepper(.data = Titanic, .recipe_formula = Survived ~ .)
#' rec_obj <- hai_knn_data_prepper(iris, Species ~ .)
#' get_juiced_data(rec_obj)
#'
#' @return
#' A recipe object
#'
#' @export
#'

hai_knn_data_prepper <- function(.data, .recipe_formula){

    # Recipe ---
    rec_obj <- recipes::recipe(.recipe_formula, data = .data) %>%
        recipes::step_novel(recipes::all_nominal_predictors()) %>%
        recipes::step_dummy(recipes::all_nominal_predictors(), one_hot = TRUE) %>%
        recipes::step_zv(recipes::all_predictors()) %>%
        recipes::step_normalize(recipes::all_numeric())

    # Return ----
    return(rec_obj)

}
