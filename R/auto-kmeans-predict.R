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
#' information. The items that are returned are as follows:
#'   1. prediction - The h2o dataframe of predictions
#'   2. prediction_tbl - The h2o predictions in tibble format
#'   3. valid_tbl - The validation data in tibble format
#'   4. pred_full_tbl - The entire validation set with the predictions attached using
#'      [base::cbind()]. The predictions are in a column called `predicted_cluster` and
#'      are in the formate of a factor using [forcats::as_factor()]
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
#'
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
    pred_tbl   <- tibble::as_tibble(prediction) %>%
        purrr::set_names("predicted_cluster")

    valid_tbl <- newdata %>% tibble::as_tibble()

    final_pred_tbl <- cbind(valid_tbl, pred_tbl) %>%
        dplyr::mutate(predicted_cluster = forcats::as_factor(predicted_cluster))

    # Return ----
    output <- list(
        prediction     = prediction,
        prediction_tbl = pred_tbl,
        valid_tbl      = valid_tbl,
        pred_full_tbl  = final_pred_tbl
    )

    return(output)

}
