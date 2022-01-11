#' Get Distribution Data Helper
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details This function expects to take the output of the `hai_distribution_comparison_tbl()`
#' function. It returns a tibble of the distribution and the randomly generated
#' data produced from the associated stats r function like `rnorm`
#'
#' @description This function will return a tibble that can either be nested/unnested,
#' and grouped or ungrouped. The `.data` argument must be the output of the
#' `hai_distribution_comparison_tbl()` function.
#'
#' @param .data The data from the `hai_distribution_comparison_tbl()` function
#' as this function looks for a class of 'hai_dist_data'
#' @param .unnest Should the resulting tibble be unnested, a boolean value TRUE/FALSE.
#' The default is TRUE
#' @param .group_data Shold the resulting tibble be grouped, a boolean value TRUE/FALSE.
#' The default is FALSE
#'
#' @examples
#' library(dplyr)
#'
#' df <- hai_scale_zero_one_vec(.x = mtcars$mpg) %>%
#'   hai_distribution_comparison_tbl()
#' hai_get_dist_data_tbl(df)
#'
#' @return
#' A tibble.
#'
#' @export
#'

hai_get_dist_data_tbl <- function(.data, .unnest = TRUE, .group_data = FALSE){

    # Tidyeval ----
    unnest_bool     <- as.logical(.unnest)
    group_data_bool <- as.logical(.group_data)

    # Get Data ----
    data_tbl <- .data

    if(!"hai_dist_tbl" %in% class(data_tbl)){
        stop(call. = FALSE, ".data must be of class `hai_dist_data`. Did you use
         the `haid_distribution_comparison_tbl()` function?")
    }

    # Names ----
    col_nms <- names(data_tbl)

    # Checks ----
    if((!"dist_data" %in% col_nms) | (!"density_data" %in% col_nms)){
        stop(call. = FALSE, ".data must be of class `hai_dist_data`. Did you use
         the `hai_distribution_comparison_tbl()` function?")
    }

    if((!is.logical(unnest_bool)) | (!is.logical(group_data_bool))){
        stop(call. = FALSE, "Both .unnest and .group_data must be a logical/boolean value.")
    }

    # Get tibble ----
    data_tbl <- tibble::as_tibble(.data)

    data_tbl <- data_tbl %>%
        dplyr::select(-density_data)

    if(unnest_bool){
        data_tbl <- data_tbl %>%
            tidyr::unnest(dist_data) %>%
            dplyr::ungroup()
    }

    if(group_data_bool){
        data_tbl <- data_tbl %>%
            dplyr::group_by(distribution)
    }

    # Return ----
    return(data_tbl)

}
