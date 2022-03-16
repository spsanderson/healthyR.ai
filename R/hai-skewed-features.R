#' Get Skewed Feature Columns
#'
#' @author Steven P. Sandeson II, MPH
#'
#' @description Takes in a data.frame/tibble and returns a vector of names of
#' the columns that are skewed.
#'
#' @details Takes in a data.frame/tibble and returns a vector of names of the skewed
#' columns. There are two other parameters. The first is the `.threshold` parameter
#' that is set to the level of skewness you want in order to consider the column
#' too skewed. The second is `.drop_keys`, these are columns you don't want to be
#' considered for whatever reason in the skewness calculation.
#'
#' @param .data The data.frame/tibble you are passing in.
#' @param .threshold A level of skewness that indicates where you feel a column
#' should be considered skewed.
#' @param .drop_keys A c() character vector of columns you do not want passed to
#' the function.
#'
#' @examples
#' hai_skewed_features(mtcars)
#' hai_skewed_features(mtcars, .drop_keys = c("mpg","hp"))
#' hai_skewed_features(mtcars, .drop_keys = "hp")
#'
#' @return
#' A character vector of column names that are skewed.
#'
#' @export
#'

hai_skewed_features <- function(.data, .threshold = 0.6, .drop_keys = NULL){

    # Tidyeval ----
    threshold <- as.numeric(.threshold)
    drop_keys <- .drop_keys

    # Checks ----
    if (!is.numeric(threshold)){
        rlang::abort(
            message = "The '.threshold' parameter must be numeric.",
            use_cli_format = TRUE
        )
    }

    if (!is.data.frame(.data)){
        rlang::abort(
            message = "The '.data' parameter must be a data.frame/tibble.",
            use_cli_format = TRUE
        )
    }

    if (!is.null(drop_keys) & !is.character(drop_keys)){
        rlang::abort(
            message = "If provided, the '.drop_keys' parameter must be a 'character'. Using
      something like '.drop_keys = c('key_1','key_2',...).",
            use_cli_format = TRUE
        )
    }

    # Data ----
    data_tbl <- tibble::as_tibble(.data)

    # Transforms
    skewed_feature_names <- data_tbl %>%
        dplyr::select(tidyselect::vars_select_helpers$where(is.numeric)) %>%
        purrr::map_df(hai_skewness_vec) %>%
        tidyr::pivot_longer(cols = dplyr::everything()) %>%
        dplyr::filter(!name %in% drop_keys) %>%
        dplyr::mutate(name = as.factor(name)) %>%
        dplyr::rename(key = name) %>%
        dplyr::filter(value >= threshold) %>%
        dplyr::pull(key) %>%
        as.character()

    # Return ----
    return(skewed_feature_names)

}
