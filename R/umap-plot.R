#' UMAP and K-Means Cluster Visualization
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @family UMAP
#'
#' @description Create a UMAP Projection plot.
#'
#' @seealso
#' *  \url{https://cran.r-project.org/package=uwot} (CRAN)
#' *  \url{https://github.com/jlmelville/uwot} (GitHub)
#' *  \url{https://github.com/jlmelville/uwot} (arXiv paper)
#'
#' @details This takes in `umap_kmeans_cluster_results_tbl` from the [umap_list()]
#' function output.
#'
#' @param .data The data from the [umap_list()] function.
#' @param .point_size The desired size for the points of the plot.
#' @param .label Should [ggrepel::geom_label_repel()] be used to display cluster
#' user labels.
#'
#' @examples
#' library(healthyR.data)
#' library(dplyr)
#' library(broom)
#' library(ggplot2)
#'
#' data_tbl <- healthyR_data %>%
#'   filter(ip_op_flag == "I") %>%
#'   filter(payer_grouping != "Medicare B") %>%
#'   filter(payer_grouping != "?") %>%
#'   select(service_line, payer_grouping) %>%
#'   mutate(record = 1) %>%
#'   as_tibble()
#'
#' uit_tbl <- hai_kmeans_user_item_tbl(
#'   .data = data_tbl,
#'   .row_input = service_line,
#'   .col_input = payer_grouping,
#'   .record_input = record
#' )
#'
#' kmm_tbl <- hai_kmeans_mapped_tbl(uit_tbl)
#'
#' ump_lst <- hai_umap_list(.data = uit_tbl, kmm_tbl, 3)
#'
#' hai_umap_plot(.data = ump_lst, .point_size = 3)
#'
#' @return A ggplot2 UMAP Projection with clusters represented by colors.
#'
#' @export
#'

hai_umap_plot <- function(.data, .point_size = 2, .label = TRUE) {

  # * Checks ----
  if (!is.list(.data)) {
    stop(call. = FALSE, "(.data) is not a list")
  }

  # * Data ----
  ump_lst <- .data
  ump_tbl <- ump_lst$umap_kmeans_cluster_results_tbl
  optimal_k <- max(ump_lst$kmeans_obj$cluster)

  umap_plt <- ump_tbl %>%
    ggplot2::ggplot(
      mapping = ggplot2::aes(
        x = x,
        y = y
      )
    ) +
    ggplot2::geom_point(size = .point_size, ggplot2::aes(col = .cluster)) +
    ggplot2::theme_minimal() +
    ggplot2::labs(
      subtitle = "UMAP 2D Projection with K-Means Cluster Assignment",
      caption = stringr::str_c(
        "Conclusion:",
        optimal_k,
        "Clusters Identified",
        sep = " "
      ),
      color = "Cluster"
    )

  if (.label) {
    ump_label <- ump_lst$umap_kmeans_cluster_results_tbl[[3]]

    umap_plt <- umap_plt +
      ggrepel::geom_label_repel(
        mapping = ggplot2::aes(
          label = ump_label
        )
      )
  }

  # * Return ----
  print(umap_plt)
}

#' @rdname hai_umap_plot
#' @export
umap_plt <- hai_umap_plot
