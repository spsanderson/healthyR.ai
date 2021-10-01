#' Data Preprocessor
#'
#' @family Data Wrangling
#' @family Preprocessor
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @description
#' Takes in a data.frame/tibble and transforms it into a processed data.frame/tibble.
#'
#' @details
#' This function will get your data ready for processing with many types of ml/ai
#' models. This function works with a recipe object.
#'
#' @param .data The data that you want to process
#'
#' @examples
#' suppressPackageStartupMessages(library(dplyr))
#' suppressPackageStartupMessages(library(recipes))
#'
#' date_seq <- seq.Date(from = as.Date("2013-01-01"), length.out = 100, by = "month")
#' val_seq  <- rep(c(rnorm(9), NA), times = 10)
#' df_tbl   <- tibble(
#'     date_col = date_seq,
#'     value    = val_seq
#' )
#'
#' rec_obj <- recipe(value ~., df_tbl)
#'
#' hai_data_preprocessor()
#'
#' @return
#' A processed data.frame/tibble.
#'
#' @export
#'

hai_data_preprocessor <- function(.data){

    # * Tidyeval ----

    # * Checks ----
    if(!is.data.frame(.data)){
        stop(call. = FALSE, "(.data) must be a data.frame/tibble.")
    }

    # * Manipulation ----
    data_tbl <- tibble::as_tibble(.data)

    # ** Data Splits ----
    data_numeric_tbl <- data_tbl %>%
        dplyr::select_if(is.numeric)

    data_fct_tbl <- data_tbl %>%
        dplyr::select_if(is.factor)

    data_dttm_tbl <- data_tbl %>%
        dplyr::select_if(timetk::is_date_class)

    # * Return ----
    return(data_tbl)
}
