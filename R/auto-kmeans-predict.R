#' Automatic K-Means H2O
#'
#' @family Kmeans
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @description
#' This is a wrapper around the [h2o::h2o.predict()] function that will return a list
#' object with a lot of useful and easy to use tidy style information.
#'
#' @details
#' This function will internally take in the output assigned from the
#' [healthyR.ai::hai_kmeans_automl()] function only and return a list of useful
#' information.
#'
#' @param .input This is the output of the [healthyR.ai::hai_kmeans_automl()] function.
#'
#' @examples
#' \dontrun{
#' h2o.init()
#'
#' output <- hai_kmeans_automl(
#'     .data = iris,
#'     .predictors = c("Sepal.Width","Sepal.Length","Petal.Width","Petal.Length"),
#'     .standardize = FALSE
#' )
#' pred <- hai_kmeans_automl_predict(output)
#'
#' h2o.shutdown()
#' }
#'
#' @return A list object
#'
#' @export
#'

hai_kmeans_automl_predict <- function(.input){



}
