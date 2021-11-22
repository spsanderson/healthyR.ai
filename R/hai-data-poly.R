#' Data Preprocessor - Polynomial Function
#'
#' @family Data Recipes
#' @family Preprocessor
#'
#' @keywords internal
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @description
#' Takes in a recipe and will scale values using a selected recipe. This function
#' is not exported but may be called via the ::: method.
#'
#' @details
#' This function will get your data ready for processing with many types of ml/ai
#' models.
#'
#' This is intended to be used inside of the data processor and
#' therefore is an internal function. This documentation exists to explain the process
#' and help the user understand the parameters that can be set in the pre-processor function.
#'
#' [recipes::step_hyperbolic()]
#' @seealso \url{https://recipes.tidymodels.org/reference/step_poly.html}
#'
#' @param .recipe_object The data that you want to process
#' @param ... One or more selector functions to choose variables to be imputed.
#' When used with imp_vars, these dots indicate which variables are used to
#' predict the missing data in each variable. See selections() for more details
#' @param .p_degree The polynomial degree, an integer.
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
#' healthyR.ai:::hai_data_poly(
#'     .recipe_object = rec_obj,
#'     value
#' )$scale_rec_obj %>%
#'     get_juiced_data()
#'
#' @return
#' A list object
#'

hai_data_poly <-  function(.recipe_object = NULL, ...,
                           .p_degree = 2){

    # Make sure a recipe was passed
    if(is.null(.recipe_object)){
        rlang::abort("`.recipe_object` must be passed, please add.")
    } else {
        rec_obj <- .recipe_object
    }

    # * Parameters ----
    terms  <- rlang::enquos(...)
    degree <- as.double(.p_degree)

    # * Checks ----
    if(!is.double(degree)){
        stop(call. = FALSE, "(.p_degree) must be an integer.")
    }

    # If Statement to get the recipe desired ----
    scale_obj <- recipes::step_poly(
            recipe  = rec_obj,
            degree  = degree,
            !!! terms
        )

    # * Recipe List ---
    output <- list(
        rec_base      = rec_obj,
        scale_rec_obj = scale_obj
    )

    # * Return ----
    return(output)

}
