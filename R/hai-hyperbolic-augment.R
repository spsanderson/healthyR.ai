#' Augment Function Hyperbolic
#'
#' @family Augment Function
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @description
#' Takes a numeric vector(s) and will return a tibble of one of the following:
#' -  "sin"
#' -  "cos"
#' -  "tan"
#' -  "sincos"
#' -  c("sin","cos","tan", "sincos")
#'
#' @details
#' Takes a numeric vector and will return a vector of one of the following:
#' -  "sin"
#' -  "cos"
#' -  "tan"
#' -  "sincos"
#' -  c("sin","cos","tan", "sincos")
#'
#' This function is intended to be used on its own in order to add columns to a
#' tibble.
#'
#' @param .data The data being passed that will be augmented by the function.
#' @param .value This is passed [rlang::enquo()] to capture the vectors you want
#' to augment.
#' @param .names The default is "auto"
#' @param .scale_type A character of one of the following: "sin","cos","tan", "sincos" All
#' can be passed by setting the param equal to c("sin","cos","tan","sincos")
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
#' hai_hyperbolic_augment(data_tbl, c(a, b), .scale_type = c("sin", "sincos"))
#' hai_hyperbolic_augment(data_tbl, c(a, b), .scale_type = c("sin","cos","tan"))
#'
#' @return
#' A augmented tibble
#'
#' @export
#

hai_hyperbolic_augment <- function(.data
                                   , .value
                                   , .names = "auto"
                                   , .scale_type = c("sin","cos","tan","sincos")
){

    column_expr <- rlang::enquo(.value)

    if(rlang::quo_is_missing(column_expr)) stop(call. = FALSE, "hyperbolic_augment(.value) is missing.")

    col_nms <- names(tidyselect::eval_select(rlang::enquo(.value), .data))

    make_call <- function(col, scale_type){
        rlang::call2(
            "hai_hyperbolic_vec",
            x             = rlang::sym(col)
            , .scale_type = scale_type
            , .ns         = "healthyR.ai"
        )
    }

    grid <- expand.grid(
        col                = col_nms
        , scale_type       = .scale_type
        , stringsAsFactors = FALSE
    )

    calls <- purrr::pmap(.l = list(grid$col, grid$scale_type), make_call)

    if(any(.names == "auto")) {
        newname <- paste0(grid$col, "_", grid$scale_type)
    } else {
        newname <- as.list(.names)
    }

    calls <- purrr::set_names(calls, newname)

    ret <- tibble::as_tibble(dplyr::mutate(.data, !!!calls))

    return(ret)

}
