#' Metric Set
#'
#' @family Default Metric Sets
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details Default regression metric sets from `yardstick`
#'
#' @description Default regression metric sets from `yardstick`
#'
#' @examples
#' hai_default_regression_metric_set()
#'
#' @return
#' A yardstick metric set tibble
#'
#' @export
#'

hai_default_regression_metric_set <- function(){

    yardstick::metric_set(
        yardstick::mae,
        yardstick::mape,
        yardstick::mase,
        yardstick::smape,
        yardstick::rmse,
        yardstick::rsq
    )
}

#' Metric Set
#'
#' @family Default Metric Sets
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details Default classification metric sets from `yardstick`
#'
#' @description Default classification metric sets from `yardstick`
#'
#' @examples
#' hai_default_classification_metric_set()
#'
#' @return
#' A yardstick metric set tibble
#'
#' @export
#'

hai_default_classification_metric_set <- function(){

    yardstick::metric_set(
        yardstick::sensitivity,
        yardstick::specificity,
        yardstick::recall,
        yardstick::precision,
        yardstick::mcc,
        yardstick::accuracy,
        yardstick::f_meas,
        yardstick::kap,
        yardstick::ppv,
        yardstick::npv,
        yardstick::bal_accuracy
    )
}
