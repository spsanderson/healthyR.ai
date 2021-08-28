#' Perform PCA
#'
#' @family Data Wrangling
#' @family Data Recipes
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @description
#' This is a simple function that will perform PCA analysis on a passed tibble.
#'
#' @details
#' This is a simple wrapper around some recipes functions to perform a PCA on a
#' given data set. This function will output a list and return it invisible.
#' All of the components of the analysis will be returned in a list as their own
#' object that can be selected individually. A scree plot is also included.
#'
#' @param .recipe_object The recipe object you want to pass.
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
#' get_juiced_data(rec_obj)
#'
#' @return
#' A tibble of the prepped and juiced data from the given recipe
#'
#' @export
#'
