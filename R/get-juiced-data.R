#' Get the Juiced Data
#'
#' @family Data Generation
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @description
#' This is a simple function that will get the juiced data from a recipe.
#'
#' @details
#' Instead of typing out something like:
#'   \code{recipe_object %>% prep() %>% juice() %>% glimpse()}
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
#'   select(visit_end_date_time) %>%
#'   summarise_by_time(
#'     .date_var = visit_end_date_time,
#'     .by       = "month",
#'     value     = n()
#'   ) %>%
#'   set_names("date_col", "value") %>%
#'   filter_by_time(
#'     .date_var = date_col,
#'     .start_date = "2013",
#'     .end_date = "2020"
#'   )
#'
#' splits <- initial_split(data = data_tbl, prop = 0.8)
#'
#' rec_obj <- recipe(value ~ ., training(splits))
#'
#' get_juiced_data(rec_obj)
#'
#' @return
#' A tibble of the prepped and juiced data from the given recipe
#'
#' @export
#'

get_juiced_data <- function(.recipe_object) {

  # Variables ----
  rec_obj <- .recipe_object

  # * Checks ----
  # Is the .recipe_object in fact a class of recipe?
  if (!inherits(x = rec_obj, what = "recipe")) {
    stop(call. = FALSE, "You must supply an object of class recipe.")
  }

  # * Juice it!
  j_data <- rec_obj %>%
    recipes::prep() %>%
    recipes::juice()

  # * Return ----
  return(j_data)
}
