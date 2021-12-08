#' Vector Function Winsorize Move
#'
#' @family Vector Function
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @description
#' Takes a numeric vector and will return a vector of winsorized values.
#'
#' @details
#' Takes a numeric vector and will return a winsorized vector of values that have
#' been moved some multiple from the mean absolute deviation zero center of some
#' vector. The intent of winsorization is to limit the effect of extreme values.
#'
#' @seealso \url{https://en.wikipedia.org/wiki/Winsorizing}
#'
#' This function can be used on it's own. It is also the basis for the function
#' [healthyR.ai::hai_winsorized_move_augment()].
#'
#' @param .x A numeric vector
#' @param .multiple A positive number indicating how many times the the zero center
#' mean absolute deviation should be multiplied by for the scaling parameter.
#'
#' @examples
#' suppressPackageStartupMessages(library(dplyr))
#'
#' len_out    = 25
#' by_unit    = "month"
#' start_date = as.Date("2021-01-01")
#'
#' data_tbl <- tibble(
#'   date_col = seq.Date(from = start_date, length.out = len_out, by = by_unit),
#'   a    = rnorm(len_out),
#'   b    = runif(len_out)
#' )
#'
#' vec_1 <- hai_winsorized_move_vec(data_tbl$a, .multiple = 1)
#'
#' plot(data_tbl$a)
#' lines(data_tbl$a)
#' lines(vec_1, col = "blue")
#'
#' @return
#' A numeric vector
#'
#' @export
#'

hai_winsorized_move_vec <- function(.x, .multiple = 3){

    # Tidyeval ----
    x_term <- .x

    if(length(.multiple) != 1 || .multiple <= 0){
        stop(call. = FALSE, ".multiple is a vad value.")
    }

    med <- stats::median(x_term)
    y <- x_term - med
    sc <- stats::mad(y, center = 0) * .multiple

    y[y > sc] <- sc
    y[y < -sc] <- -sc

    ret <- y + med

    return(ret)

}

