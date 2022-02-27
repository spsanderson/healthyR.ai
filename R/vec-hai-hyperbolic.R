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
#' -  "sincos" This will do value = sin(x) * cos(x)
#'
#' @details
#' Takes a numeric vector and will return a vector of one of the following:
#' -  "sin"
#' -  "cos"
#' -  "tan"
#' -  "sincos"
#'
#' This function can be used on it's own. It is also the basis for the function
#' [healthyR.ai::hai_hyperbolic_augment()].
#'
#' @param .x A numeric vector
#' @param .scale_type A character of one of the following: "sin","cos","tan","sincos"
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
#' vec_1 <- hai_hyperbolic_vec(data_tbl$b, .scale_type = "sin")
#' vec_2 <- hai_hyperbolic_vec(data_tbl$b, .scale_type = "cos")
#' vec_3 <- hai_hyperbolic_vec(data_tbl$b, .scale_type = "sincos")
#'
#' plot(data_tbl$b)
#' lines(vec_1, col = "blue")
#' lines(vec_2, col = "red")
#' lines(vec_3, col = "green")
#'
#' @return
#' A numeric vector
#'
#' @export
#'

hai_hyperbolic_vec <- function(.x, .scale_type = c("sin","cos","tan","sincos")){

    if(inherits(x = .x, "Date")){
        x_term <- as.numeric(.x) %>% as.integer()
    } else if(inherits(x = .x, "POSIXct")) {
        x_term <- as.numeric(.x) %>% as.integer()
    } else {
        x_term <- .x
    }

    scale_type = base::as.character(.scale_type)
    term       = x_term

    if (scale_type == "sin"){
        ret <- base::sin(term)
    } else if (scale_type == "cos") {
        ret <- base::cos(term)
    } else if (scale_type == "tan") {
        ret <- base::tan(term)
    } else if (scale_type == "sincos") {
        ret <- base::sin(term) * base::cos(term)
    }

    return(ret)

}
