#' Augment Function Scale Zero One
#'
#' @family Augment Function
#' @family Scale
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @description
#' Takes a numeric vector and will return a vector that has been scaled by mean
#' and standard deviation
#'
#' @details
#' Takes a numeric vector and will return a vector that has been scaled by mean
#' and standard deviation.
#'
#' The input vector must be numeric. The computation is fairly straightforward.
#' This may be helpful when trying to compare the distributions of data where a
#' distribution like beta from the `fitdistrplus` package which requires data to be
#' between 0 and 1
#'
#' \deqn{y[h] = (x - mean(x) / sd(x))}
#'
#' This function is intended to be used on its own in order to add columns to a
#' tibble.
#'
#' @param .data The data being passed that will be augmented by the function.
#' @param .value This is passed [rlang::enquo()] to capture the vectors you want
#' to augment.
#' @param .names This is set to 'auto' by default but can be a user supplied
#' character string.
#'
#' @examples
#' df <- data.frame(x = mtcars$mpg)
#' hai_scale_zscore_augment(df, x)
#'
#' @return
#' An augmented tibble
#'
#' @export
#

hai_scale_zscore_augment <- function(.data, .value, .names = "auto"){

    column_expr <- rlang::enquo(.value)

    if(rlang::quo_is_missing(column_expr)){
        stop(call. = FALSE, "The .value argument must be supplied.")
    }

    col_nms <- names(tidyselect::eval_select(rlang::enquo(.value), .data))

    make_call <- function(col){
        rlang::call2(
            "hai_scale_zscore_vec",
            .x = rlang::sym(col)
            , .ns = "healthyR.ai"
        )
    }

    grid <- expand.grid(
        col = col_nms
        , stringsAsFactors = FALSE
    )

    calls <- purrr::pmap(.l = list(grid$col), make_call)

    if(any(.names == "auto")){
        newname <- paste0("hai_scale_zscore_", grid$col)
    } else {
        newname <- as.list(.names)
    }

    calls <- purrr::set_names(calls, newname)

    ret <- tibble::as_tibble(dplyr::mutate(.data, !!!calls))

    return(ret)

}
