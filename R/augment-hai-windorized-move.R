#' Augment Function Winsorize Move
#'
#' @family Augment Function
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @description
#' Takes a numeric vector and will return a tibble with the winsorized values.
#'
#' @details
#' Takes a numeric vector and will return a winsorized vector of values that have
#' been moved some multiple from the mean absolute deviation zero center of some
#' vector. The intent of winsorization is to limit the effect of extreme values.
#'
#' @seealso \url{https://en.wikipedia.org/wiki/Winsorizing}
#'
#' @param .data The data being passed that will be augmented by the function.
#' @param .value This is passed [rlang::enquo()] to capture the vectors you want
#' to augment.
#' @param .multiple A positive number indicating how many times the the zero center
#' mean absolute deviation should be multiplied by for the scaling parameter.
#' @param .names The default is "auto"
#'
#' @examples
#' suppressPackageStartupMessages(library(dplyr))
#'
#' len_out    = 24
#' by_unit    = "month"
#' start_date = as.Date("2021-01-01")
#'
#' data_tbl <- tibble(
#'   date_col = seq.Date(from = start_date, length.out = len_out, by = by_unit),
#'   a    = rnorm(len_out),
#'   b    = runif(len_out)
#' )
#'
#' hai_winsorized_move_augment(data_tbl, a, .multiple = 3)
#'
#' @return
#' An augmented tibble
#'
#' @export
#'

hai_winsorized_move_augment <- function(.data, .value, .multiple, .names = "auto"){

    column_expr <- rlang::enquo(.value)

    if(rlang::quo_is_missing(column_expr)) stop(call. = FALSE, "winsorized_augment(.value) is missing.")

    col_nms <- names(tidyselect::eval_select(rlang::enquo(.value), .data))

    make_call <- function(col, multiple){
        rlang::call2(
            "hai_winsorized_move_vec",
            .x            = rlang::sym(col)
            , .multiple   = multiple
            , .ns         = "healthyR.ai"
        )
    }

    grid <- expand.grid(
        col                = col_nms
        , multiple         = .multiple
        , stringsAsFactors = FALSE
    )

    calls <- purrr::pmap(.l = list(grid$col, grid$multiple), make_call)

    if(any(.names == "auto")) {
        newname <- paste0("winsor_scale_", grid$col)
    } else {
        newname <- as.list(.names)
    }

    calls <- purrr::set_names(calls, newname)

    ret <- tibble::as_tibble(dplyr::mutate(.data, !!!calls))

    return(ret)

}
