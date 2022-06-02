#' Prep Data for glmnet - Recipe
#'
#' @family Preprocessor
#' @family knn
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details This function will automatically prep your data.frame/tibble for
#' use in the glmnet algorithm. It expects data to be presented in a certain fashion.
#'
#' This function will output a recipe specification.
#'
#' @description Automatically prep a data.frame/tibble for use in the glmnet algorithm.
#'
#' @param .data The data that you are passing to the function. Can be any type
#' of data that is accepted by the `data` parameter of the `recipes::reciep()`
#' function.
#' @param .recipe_formula The formula that is going to be passed. For example
#' if you are using the `iris` data then the formula would most likely be something
#' like `Species ~ .`
#'
#' @examples
#' hai_glmnet_data_prepper(.data = Titanic, .recipe_formula = Survived ~ .)
#' rec_obj <- hai_glmnet_data_prepper(Titanic, Survived ~ .)
#' get_juiced_data(rec_obj)
#'
#' @return
#' A recipe object
#'
#' @export
#'

hai_glmnet_data_prepper <- function(.data, .recipe_formula){

    # Recipe ---
    rec_obj <- recipes::recipe(.recipe_formula, data = .data) %>%
        ## For modeling, it is preferred to encode qualitative data as factors
        ## (instead of character).
        recipes::step_string2factor(tidyselect::vars_select_helpers$where(is.character)) %>%
        recipes::step_novel(recipes::all_nominal_predictors()) %>%
        ## This model requires the predictors to be numeric. The most common
        ## method to convert qualitative predictors to numeric is to create
        ## binary indicator variables (aka dummy variables) from these
        ## predictors.
        recipes::step_dummy(recipes::all_nominal_predictors()) %>%
        ## Regularization methods sum up functions of the model slope
        ## coefficients. Because of this, the predictor variables should be on
        ## the same scale. Before centering and scaling the numeric predictors,
        ## any predictors with a single unique value are filtered out.
        recipes::step_zv(recipes::all_predictors()) %>%
        recipes::step_normalize(recipes::all_numeric_predictors())

    # Return ----
    return(rec_obj)

}
