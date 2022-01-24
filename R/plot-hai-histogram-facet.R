#' Histogram Facet Plot
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details Takes in a data.frame/tibble and returns a faceted historgram.
#'
#' @description This function expects a data.frame/tibble and will return a
#' faceted histogram.
#'
#' @param .data The data you want to pass to the function.
#' @param .bins The number of bins for the historgrams.
#' @param .ncol The number of columns for the facet_warp argument.
#' @param .fct_reorder Should the factor column be reordered? TRUE/FALSE, default of FALSE
#' @param .fct_rev Should the factor column be reversed? TRUE/FALSE, default of FALSE
#' @param .fill Default is `tidyquant::palaette_light()[[3]]`
#' @param .color Default is 'white'
#' @param .scale Default is 'free'
#' @param .interactive Default is FALSE, TRUE will produce a `plotly` plot.
#'
#' @examples
#'
#' hai_histogram_facet_plot(.data = iris)
#'
#' @return
#' A ggplot or plotly plot
#'
#' @export
#'

hai_histogram_facet_plot <- function(.data, .bins = 10, .ncol = 5, .fct_reorder = FALSE,
                                 .fct_rev = FALSE, .fill = tidyquant::palette_light()[[3]],
                                 .color = "white", .scale = "free", .interactive = FALSE) {

    # Tidyeval ----
    bins <- as.numeric(.bins)
    n_col <- as.numeric(.ncol)
    fctreorder <- as.logical(.fct_reorder)
    fctrev <- as.logical(.fct_rev)
    fill <- .fill
    color <- .color
    scale <- .scale

    # Checks ----
    if(!is.data.frame(.data)){
        rlang::abort(".data must be a data.frame/tibble.")
    }

    if(!is.numeric(bins) | !is.numeric(n_col) | bins <= 0 | n_col <= 0){
        rlang::abort(".bins and .ncol must be class numeric, and greater than 0.")
    }

    # Data ----
    data <- dplyr::as_tibble(.data)

    data_factored <- data %>%
        dplyr::mutate(
            dplyr::across(
                .cols = tidyselect::vars_select_helpers$where(is.character),
                .fns = as.factor
            )
        ) %>%
        dplyr::mutate(
            dplyr::across(
                .cols = tidyselect::vars_select_helpers$where(is.factor),
                .fns = as.numeric
            )
        ) %>%
        tidyr::gather(key = key, value = value, factor_key = TRUE)

    if (fctreorder) {
        data_factored <- data_factored %>%
            dplyr::mutate(key = as.character(key) %>% as.factor())
    }

    if (fctrev){
        data_factored <- data_factored %>%
            dplyr::mutate(key = fct_rev(key))
    }

    g <- data_factored %>%
        ggplot2::ggplot(ggplot2::aes(x = value, group = key)) +
        ggplot2::geom_histogram(bins = bins, fill = fill, color = color) +
        ggplot2::facet_wrap(~ key, ncol = n_col, scale = scale) +
        ggplot2::theme_minimal()

    if(.interactive){
        g <- plotly::ggplotly(g)
    }

    return(g)
}
