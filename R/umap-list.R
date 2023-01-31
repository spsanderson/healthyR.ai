#' UMAP Projection
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @family UMAP
#'
#' @description Create a umap object from the [uwot::umap()] function.
#'
#' @seealso
#' *  \url{https://cran.r-project.org/package=uwot} (CRAN)
#' *  \url{https://github.com/jlmelville/uwot} (GitHub)
#' *  \url{https://github.com/jlmelville/uwot} (arXiv paper)
#'
#' @details This takes in the user item table/matix that is produced by
#' [hai_kmeans_user_item_tbl()] function. This function uses the defaults of
#' [uwot::umap()].
#'
#' @param .data The data from the [hai_kmeans_user_item_tbl()] function.
#' @param .kmeans_map_tbl The data from the [hai_kmeans_mapped_tbl()].
#' @param .k_cluster Pick the desired amount of clusters from your analysis of
#' the scree plot.
#'
#' @examples
#' library(healthyR.data)
#' library(dplyr)
#' library(broom)
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
#' umap_list(.data = uit_tbl, kmm_tbl, 3)
#'
#' @return A list of tibbles and the umap object
#'
#' @export
#'

hai_umap_list <- function(.data,
                          .kmeans_map_tbl,
                          .k_cluster = 5) {
  # * Tidyeval ----
  k_cluster_var_expr <- .k_cluster

  # * Checks ----
  if (!is.data.frame(.data)) {
    stop(
      call. = FALSE,
      "(.data) is not a data.frame/tibble. Please supply."
    )
  }

  if (!is.data.frame(.kmeans_map_tbl)) {
    stop(
      call. = FALSE,
      "(.kmeans_map_tbl) is not a data.frame/tibble. Please supply."
    )
  }

  # * Data ----
  data <- tibble::as_tibble(.data)
  kmeans_map_tbl <- tibble::as_tibble(.kmeans_map_tbl)

  # * Manipulation ----
  umap_obj <- data %>%
    dplyr::select(-1) %>%
    uwot::umap()

  umap_results_tbl <- umap_obj %>%
    tibble::as_tibble(.name_repair = "unique") %>%
    purrr::set_names("x", "y") %>%
    dplyr::bind_cols(data %>% dplyr::select(1))

  kmeans_obj <- kmeans_map_tbl %>%
    dplyr::pull(k_means) %>%
    purrr::pluck(k_cluster_var_expr)

  kmeans_cluster_tbl <- kmeans_obj %>%
    broom::augment(data) %>%
    dplyr::select(1, .cluster)

  umap_kmeans_cluster_results_tbl <- umap_results_tbl %>%
    dplyr::left_join(kmeans_cluster_tbl)

  # * Data List ----
  list_names <-
    df_list <- list(
      umap_obj                        = umap_obj,
      umap_results_tbl                = umap_results_tbl,
      kmeans_obj                      = kmeans_obj,
      kmeans_cluster_tbl              = kmeans_cluster_tbl,
      umap_kmeans_cluster_results_tbl = umap_kmeans_cluster_results_tbl
    )

  # * Return ----
  return(df_list)
}

#' @rdname hai_umap_list
#' @export
umap_list <- hai_umap_list
