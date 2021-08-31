#' Automatic K-Means H2O
#'
#' @family Clustering
#' @family Kmeans
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @description
#' This is a wrapper around the [h2o.kmeans()] function that will return a list
#' object with a lot of useful and easy to use tidy style information.
#'
#' @details
#'
#' @param .data The data that is to be passed for clustering.
#' @param .split_ratio The ratio for training and testing splits.
#' @param .seed The default is 1234, but can be set to any integer.
#' @param .centers The default is 1. Specify the number of clusters (groups of data)
#' in a data set.
#' @param .num_folds The number of folds for cross-validation
#' @param .max_iterations The default is 100. This specifies the number of training
#' iterations
#' @param .stardardize The default is set to TRUE. When TRUE all numeric columns
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
#'
#' @examples
#'
#' @return
#'
#' @export
#'

hai_auto_kmeans <- function(.data, .split_ratio) {

    # * H2O Initialize ----
    h2o::h2o.init()

    # * Tidyeval ----
    split_ratio <- .split_ratio

    # * Checks ----
    if(!is.data.frame(.data)){
        stop(call. = FALSE, "(.data) must be a data.frame/tibble.")
    }

    if(!is.numeric(split_ratio) | (split_ratio > 1) | (split_ratio < 0)){
        stop(call. = FALSE, "(.split_ratio) must be a number between 0 and 1")
    }

    # * Data ----
    data_tbl <- tibble::as_tibble(.data)
    # Convert to h2o data frame
    data_tbl <- h2o::as.h2o(x = data_tbl)


    # * H2O Shutdown ----
    h2o::h2o.shutdown()

    # * Return ----

    print("Hi User!")
}
