#' Get Distribution Data Helper
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details
#'
#' @description
#'
#' @param
#'
#' @examples
#'
#' @return
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
