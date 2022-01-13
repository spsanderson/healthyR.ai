#' Get Density Data Helper
#'
#' @family Distribution Functions
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details This function expects to take the output of the `hai_distribution_comparison_tbl()`
#' function. It returns a tibble of the `tidy` density data.
#'
#' @description This function will return a tibble that can either be nested/unnested,
#' and grouped or un-grouped. The `.data` argument must be the output of the
#' `hai_distribution_comparison_tbl()` function.
#'
#' @param .data The data from the `hai_distribution_comparison_tbl()` function
#' as this function looks for an attribute of `hai_dist_compare_tbl`
#' @param .unnest Should the resulting tibble be un-nested, a Boolean value TRUE/FALSE.
#' The default is TRUE
#' @param .group_data Should the resulting tibble be grouped, a Boolean value TRUE/FALSE.
#' The default is FALSE
#'
#' @examples
#' library(dplyr)
#'
#' df <- hai_scale_zero_one_vec(.x = mtcars$mpg) %>%
#'   hai_distribution_comparison_tbl()
#' hai_get_density_data_tbl(df)
#'
#' @return
#' A tibble.
#'
#' @export
#'

hai_get_density_data_tbl <- function(.data, .unnest = TRUE, .group_data = TRUE){

    # Tidyeval ----
    unnest_bool     <- as.logical(.unnest)
    group_data_bool <- as.logical(.group_data)

    # Get Data ----
    data_tbl <- .data

    if(!attributes(data_tbl)$tibble_type == "hai_dist_compare_tbl"){
        rlang::abort("Attribute of 'hai_dist_compare_tbl' is missing.
                 Did you use the 'hai_distribution_comparison_tlb()' function?")
    }

    # Names ----
    col_nms <- names(data_tbl)

    # Checks ----
    if((!"dist_data" %in% col_nms) | (!"density_data" %in% col_nms)){
        rlang::abort("Attribute of `hai_dist_compare_tbl`. Did you use
         the `hai_distribution_comparison_tbl()` function?")
    }

    # Get data and lists ----
    l        <- tibble::as_tibble(data_tbl) %>% dplyr::select(-dist_data)
    dist_nms <- dplyr::pull(l, distribution)
    l        <- l %>% dplyr::pull(density_data)
    names(l) <- dist_nms

    tidy_l <- purrr::map(.x = l, .f = broom::tidy)
    tidy_nested_tbl <- tibble::as_tibble(dist_nms) %>%
        dplyr::mutate(
            density_obj = purrr::pluck(tidy_l)
        ) %>%
        dplyr::rename(distribution = value)

    # Logic Params
    if(unnest_bool){
        data_tbl <- tidy_nested_tbl %>%
            tidyr::unnest(cols = density_obj) %>%
            dplyr::ungroup()
    }

    if(group_data_bool){
        data_tbl <- tidy_nested_tbl %>%
            tidyr::unnest(cols = density_obj) %>%
            dplyr::group_by(distribution)
    }

    # Add attributes ----
    attr(data_tbl, ".data") <- .data
    attr(data_tbl, ".unnest") <- .unnest
    attr(data_tbl, ".group_data") <- .group_data
    attr(data_tbl, "tibble_type") <- "hai_density_data_tbl"

    # Return ----
    return(data_tbl)

}
