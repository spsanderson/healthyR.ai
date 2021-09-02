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

    input <- .input

    if (!class(output) == "list"){
        stop(call. = FALSE, "(.input) should be a list object from the hai_kmeans_automl function.")
    }

    # Get validation data from input ----
    kmeans_obj <- input$auto_kmeans_obj

    newdata <- input$data$splits$validate_tbl
    newdata <- h2o::as.h2o(newdata)

    # Make prediction ----
    prediction <- h2o::h2o.predict(kmeans_obj, newdata = newdata)
    pred_tbl   <- tibble::as_tibble(prediction)

    valid_tbl <- newdata %>% tibble::as_tibble()

    final_pred_tbl <- cbind(valid_tbl, pred_tbl) %>%
        dplyr::rename("predicted_cluster" = predict)

    # Return ----
    output <- list(
        prediction     = prediction,
        prediction_tbl = pred_tbl,
        valid_tbl      = valid_tbl,
        pred_full_tbl  = final_pred_tbl
    )

    return(output)

}
