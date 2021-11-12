#' Augment Function Fourier
#'
#' @family Augment Function
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @description
#' Takes a numeric vector(s) or date and will return a tibble of one of the following:
#' -  "sin"
#' -  "cos"
#' -  "sincos"
#' -  c("sin","cos","sincos")
#'
#' @details
#' Takes a numeric vector or date and will return a vector of one of the following:
#' -  "sin"
#' -  "cos"
#' -  "sincos"
#' -  c("sin","cos","sincos")
#'
#' This function is intended to be used on its own in order to add columns to a
#' tibble.
#'
#' @param .data The data being passed that will be augmented by the function.
#' @param .value This is passed [rlang::enquo()] to capture the vectors you want
#' to augment.
#' @param .period The number of observations that complete a cycle
#' @param .order The fourier term order
#' @param .names The default is "auto"
#' @param .scale_type A character of one of the following: "sin","cos", or sincos" All
#' can be passed by setting the param equal to c("sin","cos","sincos")
#'
#' @examples
#' suppressPackageStartupMessages(library(dplyr))
#'
#' len_out    = 10
#' by_unit    = "month"
#' start_date = as.Date("2021-01-01")
#'
#' data_tbl <- tibble(
#'   date_col = seq.Date(from = start_date, length.out = len_out, by = by_unit),
#'   a    = rnorm(len_out),
#'   b    = runif(len_out)
#' )
#'
#' hai_fourier_augment(data_tbl, b, .period = 12, .order = 1, .scale_type = "sin")
#' hai_fourier_augment(data_tbl, b, .period = 12, .order = 1, .scale_type = "cos")
#'
#' @return
#' A augmented tibble
#'
#' @export
#

hai_fourier_augment <- function(.data
                                , .value
                                , .period
                                , .order
                                , .names = "auto"
                                , .scale_type = c("sin","cos","sincos")
){

    column_expr <- rlang::enquo(.value)


    if(rlang::quo_is_missing(column_expr)) stop(call. = FALSE, "fourier_augment(.value) is missing.")

    col_nms <- names(tidyselect::eval_select(rlang::enquo(.value), .data))

    make_call <- function(col, period, order, scale_type){
        rlang::call2(
            "hai_fourier_vec",
            .x            = rlang::sym(col)
            , .period     = period
            , .order      = order
            , .scale_type = scale_type
            , .ns         = "healthyR.ai"
        )
    }

    grid <- expand.grid(
        col                = col_nms
        , period           = .period
        , order            = .order
        , scale_type       = .scale_type
        , stringsAsFactors = FALSE
    )

    calls <- purrr::pmap(.l = list(grid$col, grid$period, grid$order, grid$scale_type), make_call)

    if(any(.names == "auto")) {
        newname <- paste0("fourier_", grid$col, "_", grid$scale_type)
    } else {
        newname <- as.list(.names)
    }

    calls <- purrr::set_names(calls, newname)

    ret <- tibble::as_tibble(dplyr::mutate(.data, !!!calls))

    return(ret)

}
