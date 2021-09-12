#' Data Preprocessor
#'
#' @family Data Wrangling
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @description
#' Takes in a data.frame/tibble and transforms it into a processed data.frame/tibble.
#'
#' @details
#' This function will get your data ready for processing with many types of ml/ai
#' models. This is an R translation from the PyCaret pre-processor.
#'
#' @seealso \url{https://pycaret.org/preprocessing/}
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
#' @return
#' A processed data.frame/tibble.
#'
#' @export
#'

preprocess_your_data <- function(.data){

    # * Tidyeval ----

    # * Checks ----
    if(!is.data.frame(.data)){
        stop(call. = FALSE, "(.data) must be a data.frame/tibble.")
    }

    # * Manipulation ----
    data_tbl <- tibble::as_tibble(.data)

    # ** Data Splits ----
    data_numeric_tbl <- data_tbl %>%
        dplyr::select_if(is.numberic)

    data_fct_tbl <- data_tbl %>%
        dplyr::select_if(is.factor)

    data_dttm_tbl <- data_tbl %>%
        dplyr::select_if(timetk::is_date_class)

    # * Return ----
    return(data_tbl)
}
