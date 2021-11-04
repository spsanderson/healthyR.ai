#' Vector Function Hyperbolic
#'
#' @family Vector Function
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @description
#' Takes a numeric vector and will return a vector of one of the following:
#' -  "sin"
#' -  "cos"
#' -  "tan"
#'
#' @details
#' Takes a numeric vector and will return a vector of one of the following:
#' -  "sin"
#' -  "cos"
#' -  "tan"
#'
#' This fucntion can be used on it's own. It is also the basis for the function
#' [healthyR.ai::hai_hyperbolic_augment()].
#'
#' @param .x A numeric vector
#' @param .scale_type A character of one of the following: "sin","cos","tan"
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
#' hai_hyperbolic_vec(data_tbl$a, .scale_type = "sin")
#'
#' @return
#' A numeric vector
#'
#' @export
#

hai_hyperbolic_augment <- function(.data
                                   , .value
                                   , .names = "auto"
                                   , .scale_type = c("sin","cos","tan","all")
){

    column_expr <- rlang::enquo(.value)

    if(rlang::quo_is_missing(column_expr)) stop(call. = FALSE, "hyperbolic_augment(.value) is missing.")

    col_nms <- names(tidyselect::eval_select(rlang::enquo(.value), .data))

    make_call <- function(col, scale_type){
        rlang::call2(
            "hai_hyperbolic_vec",
            x             = rlang::sym(col)
            , .scale_type = scale_type
            #, .ns = "healthyR.ai"
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
