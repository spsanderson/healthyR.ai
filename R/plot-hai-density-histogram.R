#' Density Histogram Plot
#'
#' @family Distribution Plots
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details This will produce a histogram of the density information that is
#' produced from the function `hai_get_density_data_tbl`. It will look for an attribute
#' from the `.data` param to ensure the function was used.
#'
#' @description this will produce a `ggplot2` or `plotly` histogram plot of the
#' density information provided from the `hai_get_density_data_tbl` function.
#'
#' @param .data The data that is produced from using `hai_get_density_data_tbl`
#' @param .dist_name_col The column that has the distribution name, should be
#' distribution and that is set as the default.
#' @param .value_col The column that contains the x values that comes from the
#' `hai_get_density_data_tbl` function.
#' @param .alpha The alpha parameter for ggplot
#' @param .interactive This is a Boolean fo TRUE/FALSE and is defaulted to FALSE.
#' TRUE will produce a `plotly` plot.
#'
#' @examples
#' library(dplyr)
#'
#' df <- hai_scale_zero_one_vec(.x = mtcars$mpg) %>%
#'   hai_distribution_comparison_tbl()
#'
#' dist_data_tbl <- hai_get_dist_data_tbl(df)
#'
#' hai_density_hist_plot(
#'  .data = dist_data_tbl,
#'  .dist_name_col = distribution,
#'  .value_col = dist_data,
#'  .alpha = 0.5,
#'  .interactive = FALSE
#' )
#'
#' @return
#' A plot, either `ggplot2` or `plotly`
#'
#' @export
#'

hai_density_hist_plot <- function(.data, .dist_name_col = distribution,
                                  .value_col = dist_data,
                                  .alpha = .382, .interactive = FALSE){

    # Tidyeval ----
    dist_name_var <- rlang::enquo(.dist_name_col)
    value_col_var <- rlang::enquo(.value_col)
    alpha <- as.numeric(.alpha)

    dnv_name <- rlang::quo_name(dist_name_var)
    vcv_name <- rlang::quo_name(value_col_var)

    # Checks ----
    if(rlang::quo_is_missing(dist_name_var) | rlang::quo_is_missing(value_col_var)
    ){
        rlang::abort(
            "All parameters must be supplied:
       * .dist_name_col
       * .value_col
       "
        )
    }

    if(!is.numeric(alpha) | (alpha > 1) | (alpha < 0)){
        rlang::abort("The .alpha parameter must be a number between 0 and 1")
    }

    if(!is.data.frame(.data)){
        rlang::abort("The .data argument cannot be blank.")
    }

    # Data setup ----
    data_tbl <- tibble::as_tibble(.data) %>%
        dplyr::ungroup() %>%
        dplyr::select(
            {{dist_name_var}},
            {{value_col_var}}
        )

    if(!attributes(.data)$tibble_type == "hai_dist_data_tbl"){
        rlang::abort("The attribute of tibble_type must be equal to 'hai_dist_data_tbl'.
        Did you use the 'hai_get_dist_data_tbl` function?")
    }

    # Plots ----
    plt <- ggplot2::ggplot(
        data = data_tbl,
        mapping = ggplot2::aes_string(
            x     = vcv_name,
            fill  = dnv_name
        )
    ) +
        ggplot2::geom_histogram(color = "black", alpha = alpha, binwidth = 0.05) +
        ggplot2::theme_minimal() +
        ggplot2::labs(
            title = "Density Comparison Histogram",
            fill  = "Distribution",
            x = "",
            y = ""
        ) +
        ggplot2::theme(legend.position = "bottom")

    if(.interactive){
        plt <- plotly::ggplotly(plt)
    }

    # Return ----
    return(plt)
}
