#' Collect Metrics from Boilerplat Workflows
#'
#' @family Metric_Collection
#' @family Boiler_Plate
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details This function will extract the metrics from the `hai_auto_` boilerplate
#' functions. This function looks for a specific attribute from the `hai_auto_`
#' functions so that it will extract the `tuned_results` from the tuning process
#' if it has indeed been tuned.
#'
#' @description This function will extract the metrics from the `hai_auto_` boilerplate
#' functions.
#'
#' @param .data The output of the `hai_auto_` boilerplate function in it's entirety.
#'
#' @examples
#' data <- iris
#'
#' rec_obj <- hai_knn_data_prepper(data, Species ~ .)
#'
#' auto_knn <- hai_auto_knn(
#'  .data = data,
#'  .rec_obj = rec_obj,
#'  .best_metric = "f_meas",
#'  .model_type = "classification",
#'  .grid_size = 1,
#'  .num_cores = 1
#'  )
#'
#'  hai_auto_wflw_metrics(auto_knn)
#'
#' @return
#' A tibble
#'
#' @export
#'

hai_auto_wflw_metrics <- function(.data){

    input_data <- .data
    atb <- attributes(input_data)
    tuned <- atb$.tune

    # Checks
    if (!atb$function_type == "boilerplate"){
        rlang::abort(
            message = "You need to pass in a list object from an 'hai_auto_' function.",
            use_cli_format = TRUE
        )
    }

    if (!tuned){
        rlang::abort(
            message = "The object you passed was not tuned, so there are no metrics
      for this function to collect.",
      use_cli_format = TRUE
        )
    }

    # Data
    df <- tune::collect_metrics(input_data$tuned_info$tuned_results)

    # Return
    return(df)

}
