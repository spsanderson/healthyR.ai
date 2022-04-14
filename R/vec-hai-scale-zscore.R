#' Vector Function Scale to Zero and One
#'
#' @family Vector Function
#' @family Scale
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @description
#' Takes a numeric vector and will return a vector that has been scaled from by
#' mean and standard deviation
#'
#' @details
#' Takes a numeric vector and will return a vector that has been scaled from
#' mean and standard deviation.
#'
#' The input vector must be numeric. The computation is fairly straightforward.
#' This may be helpful when trying to compare the distributions of data where a
#' distribution like beta from the `fitdistrplus` package which requires data to be
#' between 0 and 1
#'
#' \deqn{y[h] = (x - mean(x) / sd(x))}
#'
#' This function can be used on it's own. It is also the basis for the function
#' [healthyR.ai::hai_scale_zscore_augment()].
#'
#' @param .x A numeric vector to be scaled by mean and standard deviation inclusive.
#'
#' @examples
#' vec_1 <- mtcars$mpg
#' vec_2 <- hai_scale_zscore_vec(vec_1)
#'
#' ax <- pretty(min(vec_1, vec_2):max(vec_1, vec_2), n = 12)
#'
#' hist(vec_1, breaks = ax, col = "blue")
#' hist(vec_2, breaks = ax, col = "red", add = TRUE)
#'
#' @return
#' A numeric vector
#'
#' @export
#'

hai_scale_zscore_vec <- function(.x){

    # Tidyeval ----
    x_term <- .x

    # Checks ----
    if (!is.numeric(x_term)){
        rlang::abort(
            message = "'.x' must be a numeric vector",
            use_cli_format = TRUE
        )
    }

    mu <- mean(x_term, na.rm = TRUE)
    s  <- sd(x_term, na.rm = TRUE)
    zscore_scaled <- ((x_term - mu) / s)

    # Return ----
    return(zscore_scaled)

}
