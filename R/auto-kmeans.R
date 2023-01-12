#' Automatic K-Means H2O
#'
#' @family Kmeans
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @description
#' This is a wrapper around the [h2o::h2o.kmeans()] function that will return a list
#' object with a lot of useful and easy to use tidy style information.
#'
#' @param .data The data that is to be passed for clustering.
#' @param .split_ratio The ratio for training and testing splits.
#' @param .seed The default is 1234, but can be set to any integer.
#' @param .centers The default is 1. Specify the number of clusters (groups of data)
#' in a data set.
#' @param .max_iterations The default is 100. This specifies the number of training
#' iterations
#' @param .standardize The default is set to TRUE. When TRUE all numeric columns
#' will be set to zero mean and unit variance.
#' @param .categorical_encoding Can be one of the following:
#'   + "auto"
#'   + "enum"
#'   + "one_hot_explicit"
#'   + "binary"
#'   + "eigen"
#'   + "label_encoder"
#'   + "sort_by_response"
#'   + "enum_limited"
#' @param .initialization_mode This can be one of the following:
#'   + "Random"
#'   + "Furthest (default)
#'   + "PlusPlus"
#' @param .predictors This must be in the form of c("column_1", "column_2", ... "column_n")
#' @param .print_model_summary This is a boolean and controls if the model summary
#' is printed to the console. The default is TRUE.
#'
#' @examples
#' \dontrun{
#' h2o.init()
#' output <- hai_kmeans_automl(
#'   .data = iris,
#'   .predictors = c("Sepal.Width", "Sepal.Length", "Petal.Width", "Petal.Length"),
#'   .standardize = FALSE
#' )
#' h2o.shutdown()
#' }
#'
#' @return A list object
#'
#' @export
#'

hai_kmeans_automl <- function(.data, .split_ratio = 0.80, .seed = 1234,
                              .centers = 10, .standardize = TRUE,
                              .print_model_summary = TRUE,
                              .predictors, .categorical_encoding = "auto",
                              .initialization_mode = "Furthest",
                              .max_iterations = 100) {

  # * Tidyeval ----
  split_ratio <- as.numeric(.split_ratio)
  seed <- as.integer(.seed)
  centers <- as.integer(.centers)
  predictors <- .predictors
  standardize_numerics <- .standardize
  initialization_mode <- .initialization_mode
  categorical_encode <- .categorical_encoding
  max_iters <- as.integer(.max_iterations)
  print_mod_sum <- .print_model_summary

  # * Checks ----
  if (!is.data.frame(.data)) {
    stop(call. = FALSE, "(.data) must be a data.frame/tibble.")
  }

  if (!is.numeric(split_ratio) | (split_ratio > 1L) | (split_ratio < 0L)) {
    stop(call. = FALSE, "(.split_ratio) must be a number between 0 and 1.")
  }

  if (!is.integer(seed)) {
    stop(call. = FALSE, "(.seed) must be an integer.")
  }

  if (!is.integer(centers)) {
    stop(call. = FALSE, "(.centers) must be an integer.")
  }

  if (!is.integer(max_iters)) {
    stop(call. = FALSE, "(.max_iterations) must be an integer.")
  }

  if (!is.logical(standardize_numerics)) {
    stop(call. = FALSE, "(.standardize) must be a logical, TRUE/FALSE.")
  }

  if (!is.logical(print_mod_sum)) {
    stop(call. = FALSE, "(.print_model_summary) must be a logical, TRUE/FALSE.")
  }

  if (!inherits(x = predictors, what = "character")) {
    stop(call. = FALSE, "(.predictors) must be a character list like: c('col1','col2')")
  }

  if (!inherits(x = initialization_mode, what = "character")) {
    stop(call. = FALSE, "(.initialization_mode) must be a character.")
  }

  if (!initialization_mode %in% c(
    "Random", "Furthest", "PlusPlus"
  )) {
    stop(call. = FALSE, "(.initialization_mode) invalid choice made.")
  }

  if (!inherits(x = categorical_encode, what = "character")) {
    stop(call. = FALSE, "(.categorical_encoding) must be a character.")
  }

  if (!categorical_encode %in% c(
    "auto", "enum", "one_hot_explicit", "binary", "eigen", "label_encoder",
    "sort_by_response", "enum_limited"
  )) {
    stop(call. = FALSE, "(.categorical_encoding) invalid choice made.")
  }

  # * Data ----
  data_tbl <- tibble::as_tibble(.data)
  # Convert to h2o data frame
  data_tbl <- h2o::as.h2o(x = data_tbl)

  splits <- h2o::h2o.splitFrame(
    data_tbl,
    ratios = split_ratio,
    seed   = seed
  )

  training_frame <- splits[[1]]
  validate_frame <- splits[[2]]

  # * KMEANS ----
  auto_kmeans_obj <- h2o::h2o.kmeans(
    k                    = centers,
    estimate_k           = TRUE,
    seed                 = seed,
    x                    = predictors,
    standardize          = standardize_numerics,
    training_frame       = training_frame,
    validation_frame     = validate_frame,
    init                 = initialization_mode,
    categorical_encoding = categorical_encode,
    nfolds               = 5,
    max_iterations       = max_iters
  )

  # * Tidy things up ----
  training_tbl <- tibble::as_tibble(training_frame)
  validate_tbl <- tibble::as_tibble(validate_frame)

  scree_data_tbl <- auto_kmeans_obj@model[["scoring_history"]] %>%
    tibble::as_tibble() %>%
    dplyr::filter(iterations > 0) %>%
    dplyr::select(number_of_clusters, within_cluster_sum_of_squares) %>%
    dplyr::group_by(number_of_clusters) %>%
    dplyr::summarize(wss = mean(within_cluster_sum_of_squares, na.rm = TRUE)) %>%
    purrr::set_names("centers", "wss")

  scree_plt <- scree_data_tbl %>%
    ggplot2::ggplot(ggplot2::aes(x = centers, y = wss)) +
    ggplot2::geom_point(size = 3) +
    ggplot2::geom_line() +
    ggplot2::theme_bw() +
    ggplot2::labs(
      title = "Auto K-Means Scree Plot",
      x = "Centers",
      y = "Cluster WSS"
    )

  # * List ----
  # message("Hi User! K-Means all done. Have a happy day :)")

  output <- list(
    data = list(
      splits = list(
        training_tbl = training_tbl,
        validate_tbl = validate_tbl
      ),
      metrics = list(
        training_metrics = auto_kmeans_obj@model[["training_metrics"]]@metrics$centroid_stats %>%
          tibble::as_tibble(),
        validation_metrics = auto_kmeans_obj@model[["validation_metrics"]]@metrics$centroid_stats %>%
          tibble::as_tibble(),
        cv_metric_summary = auto_kmeans_obj@model[["cross_validation_metrics_summary"]] %>%
          as.data.frame() %>%
          tibble::as_tibble(rownames = "metric_name")
      ),
      original_data = data_tbl,
      scree_data_tbl = scree_data_tbl,
      scoring_history_tbl = auto_kmeans_obj@model[["scoring_history"]] %>%
        tibble::as_tibble(),
      model_summary_tbl = auto_kmeans_obj@model[["model_summary"]] %>%
        tibble::as_tibble() %>%
        tidyr::pivot_longer(cols = dplyr::everything())
    ),
    auto_kmeans_obj = auto_kmeans_obj,
    model_id = auto_kmeans_obj@model_id,
    scree_plt = scree_plt
  )

  # * Return ----
  if (print_mod_sum) {
    summary(auto_kmeans_obj)
  }
  return(invisible(output))
}
