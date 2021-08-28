#' Perform PCA
#'
#' @family Data Wrangling
#' @family Data Recipes
#' @family Dimension Reduction
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @description
#' This is a simple function that will perform PCA analysis on a passed recipe.
#'
#' @details
#' This is a simple wrapper around some recipes functions to perform a PCA on a
#' given recipe. This function will output a list and return it invisible.
#' All of the components of the analysis will be returned in a list as their own
#' object that can be selected individually. A scree plot is also included.
#'
#' @param .recipe_object The recipe object you want to pass.
#' @param .rotation A boolean that defaults to TRUE, should the rotation be returned
#' @param .center A boolean that defaults to TRUE, should the data be scaled, highly
#' advisable.
#' @param .scale A boolean that defaults to TRUE, should the data be scaled, highly
#' advisable.
#'
#' @examples
#' suppressPackageStartupMessages(library(timetk))
#' suppressPackageStartupMessages(library(dplyr))
#' suppressPackageStartupMessages(library(purrr))
#' suppressPackageStartupMessages(library(healthyR.data))
#' suppressPackageStartupMessages(library(rsample))
#' suppressPackageStartupMessages(library(recipes))
#'
#' data_tbl <- healthyR_data %>%
#'     select(visit_end_date_time) %>%
#'     summarise_by_time(
#'         .date_var = visit_end_date_time,
#'         .by       = "month",
#'         value     = n()
#'     ) %>%
#'     set_names("date_col","value") %>%
#'     filter_by_time(
#'         .date_var = date_col,
#'         .start_date = "2013",
#'         .end_date = "2020"
#'     )
#'
#' splits <- initial_split(data = data_tbl, prop = 0.8)
#'
#' rec_obj <- recipe(value ~., training(splits))
#'
#' pca_your_recipe(rec_obj)
#'
#' @return
#' A list object with several components
#'
#' @export
#'

pca_your_recipe <- function(.recipe_object, .rotation = TRUE, .center = TRUE,
                            .scale = TRUE){

    # Variables ----
    rec_obj      <- .recipe_object
    rotation_var <- .rotation
    center_var   <- .center
    scale_var    <- .scale

    # * Checks ----
    # Is the .recipe_object in fact a class of recipe?
    if (!class(rec_obj) == "recipe"){
        stop(call. = FALSE, "You must supply an object of class recipe.")
    }

    if (!is.logical(rotation_var)){
        stop(call. = FALSE, "(.rotation) must be a logical value TRUE/FALSE.")
    }

    if (!is.logical(center_var)){
        stop(call. = FALSE, "(.center) must be a logical value TRUE/FALSE.")
    }

    if (!is.logical(scale_var)){
        stop(call. = FALSE, "(.scale) must be a logical value TRUE/FALSE.")
    }

    # * Recipe steps ----
    pca_transform <- rec_obj %>%
        recipes::step_pca(
            options = list(
                retx   = rotation_var,
                center = center_var,
                scale  = scale_var
            )
        )

}
