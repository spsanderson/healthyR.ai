#' Data Preprocessor
#'
#' @family Imputation
#'
#' @keywords internal
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @description
#' Takes in a recipe and will impute missing values using a selected recipe.
#' To call the recipe use a quoted argument like "median" or "bagged". This function
#' is not exported but may be called via [healthyR.ai:::hai_data_impute()]
#'
#' @details
#' This function will get your data ready for processing with many types of ml/ai
#' models.
#'
#' This is intended to be used inside of the [healthyR.ai::hai_data_preprocessor()]
#'
#' @seealso \url{https://recipes.tidymodels.org/reference/index.html#section-step-functions-imputation/}
#'
#' @param .data The data that you want to process
#'
#' @examples
#' library(healthyR.data)
#' library(dplyr)
#'
#' data_tbl <- healthyR_data%>%
#'    filter(ip_op_flag == "I") %>%
#'    filter(payer_grouping != "Medicare B") %>%
#'    filter(payer_grouping != "?") %>%
#'    select(service_line, payer_grouping) %>%
#'    mutate(record = 1) %>%
#'    as_tibble()
#'
#' hai_data_preprocessor()
#'
#' @return
#' A processed data.frame/tibble.
#'
#' @export hai_data_impute
#'

hai_data_impute <-
