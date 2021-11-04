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
#'

hai_hyperbolic_vec <- function(x, .scale_type = c("sin","cos","tan")){

    scale_type = base::as.character(.scale_type)
    term       = x

    if (scale_type == "sin"){
        ret <- base::sin(term)
    } else if (scale_type == "cos") {
        ret <- base::cos(term)
    } else if (scale_type == "tan") {
        ret <- base::tan(term)
    }

    return(ret)

}
