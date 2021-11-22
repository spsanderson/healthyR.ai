#' Data Preprocessor - Trigonometric Functions
#'
#' @family Data Recipes
#' @family Preprocessor
#'
#' @keywords internal
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @description
#' Takes in a recipe and will scale values using a selected recipe. To call the
#' recipe use a quoted argument like "sin", "cos" or "tan". This function
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
#' @seealso \url{https://recipes.tidymodels.org/reference/step_hyperbolic.html}
#'
#' @param .recipe_object The data that you want to process
#' @param ... One or more selector functions to choose variables to be imputed.
#' When used with imp_vars, these dots indicate which variables are used to
#' predict the missing data in each variable. See selections() for more details
#' @param .type_of_scale This is a quoted argument and can be one of the following:
#' -  "sin"
#' -  "cos"
#' -  "tan"
#' @param .inverse A logical: should the inverse function be used? Default is FALSE
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
#' healthyR.ai:::hai_data_trig(
#'     .recipe_object = rec_obj,
#'     value,
#'     .type_of_scale = "sin"
#' )$scale_rec_obj %>%
#'     get_juiced_data()
#'
#' @return
#' A list object
#'

hai_data_trig <-  function(.recipe_object = NULL, ...,
                           .type_of_scale = "sin", .inverse = FALSE){

    # Make sure a recipe was passed
    if(is.null(.recipe_object)){
        rlang::abort("`.recipe_object` must be passed, please add.")
    } else {
        rec_obj <- .recipe_object
    }

    # * Parameters ----
    terms        <- rlang::enquos(...)
    scale_type   <- as.character(.type_of_scale)
    inverse_bool <- as.logical(.inverse)

    # * Checks ----
    if(!tolower(scale_type) %in% c(
        "sin","cos","tan"
      )
    ){
        stop(call. = FALSE, "(.type_of_scale) is not implemented. Please choose
             from 'sin','cos','tan'")
    }

    # If Statement to get the recipe desired ----
    if(scale_type == "sin"){
        scale_obj <- recipes::step_hyperbolic(
            recipe  = rec_obj,
            func    = scale_type,
            inverse = inverse_bool,
            !!! terms
        )
    } else if(scale_type == "cos"){
        scale_obj <- recipes::step_hyperbolic(
            recipe  = rec_obj,
            func    = scale_type,
            inverse = inverse_bool,
            !!! terms
        )
    } else if(scale_type == "tan"){
        scale_obj <- recipes::step_hyperbolic(
            recipe  = rec_obj,
            func    = scale_type,
            inverse = inverse_bool,
            !!! terms
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
