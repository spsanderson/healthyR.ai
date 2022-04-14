#' Vector Function Scale to Zero and One
#'
#' @family Vector Function
#' @family Scale
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @description
#' Takes a numeric vector and will return a vector that has been scaled from `[0,1]`
#'
#' @details
#' Takes a numeric vector and will return a vector that has been scaled from `[0,1]`
#' The input vector must be numeric. The computation is fairly straightforward.
#' This may be helpful when trying to compare the distributions of data where a
#' distribution like beta from the `fitdistrplus` package which requires data to be
#' between 0 and 1
#'
#' \deqn{y[h] = (x - min(x))/(max(x) - min(x))}
#'
#' This function can be used on it's own. It is also the basis for the function
#' [healthyR.ai::hai_scale_zero_one_augment()].
#'
#' @param .x A numeric vector to be scaled from `[0,1]` inclusive.
#'
#' @examples
#' vec_1 <- rnorm(100, 2, 1)
#' vec_2 <- hai_scale_zero_one_vec(vec_1)
#'
#' dens_1 <- density(vec_1)
#' dens_2 <- density(vec_2)
#' max_x <- max(dens_1$x, dens_2$x)
#' max_y <- max(dens_1$y, dens_2$y)
#' plot(dens_1, asp = max_y/max_x, main = "Density vec_1 (Red) and vec_2 (Blue)",
#'  col = "red", xlab = "", ylab = "Density of Vec 1 and Vec 2")
#' lines(dens_2, col = "blue")
#'
#' @return
#' A numeric vector
#'
#' @export
#'

hai_scale_zero_one_vec <- function(.x){

    # Tidyeval ----
    x_term <- .x

    # Checks ----
    if(!is.numeric(x_term)){
        stop(call. = FALSE, ".x must be a numeric verctor.")
    }

    max_x <- max(x_term)
    min_x <- min(x_term)

    zero_one_scaled <- (x_term - min_x) / (max_x - min_x)

    return(zero_one_scaled)

}
