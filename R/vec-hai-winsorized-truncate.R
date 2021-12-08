#' Vector Function Winsorize Truncate
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
#' been truncated if they are less than or greater than some defined fraction of
#' a quantile. The intent of winsorization is to limit the effect of extreme values.
#'
#' @seealso \url{https://en.wikipedia.org/wiki/Winsorizing}
#'
#' This function can be used on it's own. It is also the basis for the function
#' [healthyR.ai::hai_winsorized_truncate_augment()].
#'
#' @param .x A numeric vector
#' @param .fraction A positive fractional between 0 and 0.5 that is passed to the
#' `stats::quantile` paramater of `probs`.
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
#' vec_1 <- hai_winsorized_truncate_vec(data_tbl$a, .fraction = 0.05)
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

hai_winsorized_truncate_vec <- function(.x, .fraction = 0.05){

    # Tidyeval ----
    x_term <- .x

    if(length(.fraction) != 1 || .fraction < 0 || .fraction > 0.5){
        stop(call. = FALSE, ".fraction is a bad value.")
    }

    lim <- stats::quantile(x_term, probs = c(.fraction, (1 - .fraction)))
    x_term[x_term < lim[1]] <- lim[1]
    x_term[x_term > lim[2]] <- lim[2]

    return(x_term)

}

