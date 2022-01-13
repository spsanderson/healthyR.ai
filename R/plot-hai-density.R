#' Density Histogram Plot
#'
#' @family Distribution Plots
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details This will produce a density plot of the density information that is
#' produced from the function `hai_get_density_data_tbl`. It will look for an attribute
#' from the `.data` param to ensure the function was used.
#'
#' @description this will produce a `ggplot2` or `plotly` histogram plot of the
#' density information provided from the `hai_get_density_data_tbl` function.
#'
#' @param .data The data that is produced from using `hai_get_density_data_tbl`
#' @param .dist_name_col The column that has the distribution name, should be
#' distribution and that is set as the default.
#' @param .x_col The x value from the tidied density object.
#' @param .y_col The y value from the tidied density object.
#' @param .size The size parameter for ggplot.
#' @param .alpha The alpha parameter for ggplot.
#' @param .interactive This is a Boolean fo TRUE/FALSE and is defaulted to FALSE.
#' TRUE will produce a `plotly` plot.
#'
#' @examples
#' library(dplyr)
#'
#' df <- hai_scale_zero_one_vec(.x = mtcars$mpg) %>%
#'   hai_distribution_comparison_tbl()
#'
#' tidy_density_tbl <- hai_get_density_data_tbl(df)
#'
#' hai_density_plot(
#'  .data = tidy_density_tbl,
#'  .dist_name_col = distribution,
#'  .x_col = x,
#'  .y_col = y,
#'  .alpha = 0.5,
#'  .interactive = FALSE
#' )
#'
#' @return
#' A plot, either `ggplot`2 or `plotly`
#'
#' @export
#'

hai_density_plot <- function(.data, .dist_name_col, .x_col, .y_col,
                             .size = 1, .alpha = 0.382, .interactive = FALSE){

    # Tidyeval ----
    dist_name_var <- rlang::enquo(.dist_name_col)
    x_col_var     <- rlang::enquo(.x_col)
    y_col_var     <- rlang::enquo(.y_col)
    size <- as.numeric(.size)
    alpha <- as.numeric(.alpha)

    dnv_name <- rlang::quo_name(dist_name_var)
    xcv_name <- rlang::quo_name(x_col_var)
    ycv_name <- rlang::quo_name(y_col_var)

    # Checks ----
    if(rlang::quo_is_missing(dist_name_var) |
       rlang::quo_is_missing(x_col_var) |
       rlang::quo_is_missing(y_col_var)
    ){
        rlang::abort(
            "All parameters must be supplied:
       * .dist_name_col,
       * .x_col, and
       * .y_col"
        )
    }

    if(!is.numeric(alpha) | (alpha > 1) | (alpha < 0)){
        rlang::abort("The .alpha parameter must be a number between 0 and 1")
    }

    if(!is.numeric(size) | (size <= 0)){
        rlang::abort("The .size parameter must be a number greater than 0")
    }

    # Data setup ----
    data_tbl <- tibble::as_tibble(.data) %>%
        dplyr::ungroup() %>%
        dplyr::select(
            {{dist_name_var}},
            {{x_col_var}},
            {{y_col_var}}
        )

    if(!attributes(.data)$tibble_type == "hai_density_data_tbl"){
        rlang::abort("Attibute of 'hai_density_data_tbl' is missing.
                 Did yo use the 'hai_get_density_data_tbl()' function?")
    }

    # Plots ---
    plt <- ggplot2::ggplot(
        data = data_tbl,
        mapping = ggplot2::aes_string(
            x = xcv_name,
            y = ycv_name,
            color = dnv_name,
            group = dnv_name
        )
    ) +
        ggplot2::geom_line(size = size, alpha = alpha) +
        ggplot2::theme_minimal() +
        ggplot2::labs(
            title = "Distribution Density Comparison",
            color = "Distribution",
            x = "",
            y = "Desnsity"
        ) +
        ggplot2::theme(legend.position = "bottom")

    if(.interactive){
        plt <- plotly::ggplotly(plt)
    }

    # Return ----
    return(plt)
}
