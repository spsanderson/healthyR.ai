#' Regression Metric Set
#'
#' @family Default Metric Sets
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details Default regression metric sets from `yardstick`
#'
#' @description Default regression metric sets from `yardstick`
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
