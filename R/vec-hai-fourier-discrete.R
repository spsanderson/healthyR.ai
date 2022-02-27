#' Vector Function Discrete Fourier
#'
#' @family Vector Function
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @description
#' Takes a numeric vector or date and will return a vector of one of the following:
#' -  "sin"
#' -  "cos"
#' -  "sincos" This will do value = sin(x) * cos(x)
#' When either of these values falls below zero, then zero else one
#'
#'
#' @details
#' Takes a numeric vector or date and will return a vector of one of the following:
#' -  "sin"
#' -  "cos"
#' -  "sincos"
#'
#' The internal caluclation is straightforward:
#' -  `sin = sin(2 * pi * h * x)`, where `h = .order/.period`
#' -  `cos = cos(2 * pi * h * x)`, where `h = .order/.period`
#' -  `sincos = sin(2 * pi * h * x) * cos(2 * pi * h * x)` where `h = .order/.period`
#'
#' This function can be used on its own. It is also the basis for the function
#' [healthyR.ai::hai_fourier_discrete_augment()].
#'
#' @param .x A numeric vector
#' @param .period The number of observations that complete a cycle
#' @param .order The fourier term order
#' @param .scale_type A character of one of the following: "sin","cos","sincos"
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
#' vec_1 <- hai_fourier_discrete_vec(data_tbl$a, .period = 12, .order = 1, .scale_type = "sin")
#' vec_2 <- hai_fourier_discrete_vec(data_tbl$a, .period = 12, .order = 1, .scale_type = "cos")
#' vec_3 <- hai_fourier_discrete_vec(data_tbl$a, .period = 12, .order = 1, .scale_type = "sincos")
#'
#' plot(data_tbl$b)
#' lines(vec_1, col = "blue")
#' lines(vec_2, col = "red")
#' lines(vec_3, col = "green")
#'
#' @return
#' A numeric vector of 1's and 0's
#'
#' @export
#'

hai_fourier_discrete_vec <- function(.x, .period, .order, .scale_type = c("sin","cos","sincos")){

    if(inherits(x = .x, "Date")){
        x_term <- as.numeric(.x) %>% as.integer()
    } else if(inherits(x = .x, "POSIXct")) {
        x_term <- as.numeric(.x) %>% as.integer()
    } else {
        x_term <- .x
    }

    x_term <- x_term
    cycle <- .period # T = cycle e.g. T = 0.02 sec/cycle 1 cycle per 0.02 sec
                     # So 1 cycle/0.02 sec = 50 cycles/sec or 50hz
    o      <- .order
    h      <- o / cycle
    scale  <- base::tolower(.scale_type[1])

    if(scale == "sin"){
        ret <- ifelse(base::sin(2 * pi * h * x_term) <= 0, 0, 1)
    } else if(scale == "cos") {
        ret <- ifelse(base::cos(2 * pi * h * x_term) <= 0, 0, 1)
    } else {
        ret <- ifelse(
            (base::sin(2 * pi * h * x_term) * base::cos(2 * pi * h * x_term)) <= 0,
            0,
            1
        )
    }

    return(ret)

}
