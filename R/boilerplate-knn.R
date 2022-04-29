#' Boilerplate Workflow
#'
#' @family Boiler_Plate
#' @family k-NN
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details
#' This uses the `parsnip::nearest_neighbor()` with the `engine` set to `kknn`
#'
#' @description This is a boilerplate function to create automatically the following:
#' -  recipe
#' -  model specification
#' -  workflow
#' -  tuned model (grid ect)
#'
#' @param .data The data being passed to the function. The time-series object.
#' @param .rec_obj This is the recipe object you want to use. You can use
#' `hai_knn_data_prepper()` and an automatic recipe_object.
#' @param .splits_obj NULL is the default, when NULL then one will be created.
#' @param .rsamp_obj NULL is the default, when NULL then one will be created. It
#' will default to creating an [rsample::mc_cv()] object.
#' @param .tune Default is TRUE, this will create a tuning grid and tuned workflow
#' @param .grid_size Default is 10
#' @param .num_cores Default is 1
#' @param .best_metric Default is "rmse". You can choose a metric depending on the
#' model_type used. If `regression` then see [healthyR.ai::hai_default_regression_metric_set()],
#' if `classification` then see [healthyR.ai::hai_default_classification_metric_set()].
#' @param .model_type Default is `regression`, can also be `classification`.
#'
#' @examples
#' \dontrun{
#' library(dplyr)
#'
#' data <- iris
#'
#' rec_obj <- hai_knn_data_prepper(data, Species ~ .)
#'
#' auto_knn <- hai_auto_knn(
#'   .data = data,
#'   .rec_obj = rec_obj,
#'   .best_metric = "f_meas",
#'   .model_type = "classification"
#' )
#'
#' auto_knn$recipe_info
#' }
#'
#' @return
#' A list
#'
#' @export
#'

hai_auto_knn <- function(.data, .rec_obj, .splits_obj = NULL, .rsamp_obj = NULL,
                         .tune = TRUE, .grid_size = 10, .num_cores = 1,
                         .best_metric = "rmse", .model_type = "regression"){

    # Tidyeval ----
    grid_size <- as.numeric(.grid_size)
    num_cores <- as.numeric(.num_cores)
    best_metric <- as.character(.best_metric)

    data_tbl <- dplyr::as_tibble(.data)

    splits <- .splits_obj
    rec_obj <- .rec_obj
    rsamp_obj <- .rsamp_obj
    model_type <- as.character(.model_type)

    # Checks ----
    if (!inherits(x = splits, what = "rsplit") && !is.null(splits)){
        rlang::abort(
            message = "'.splits_obj' must have a class of 'rsplit', use the rsample package.",
            use_cli_format = TRUE
        )
    }

    if (!inherits(x = rec_obj, what = "recipe")){
        rlang::abort(
            message = "'.rec_obj' must have a class of 'recipe'."
        )
    }

    if (!model_type %in% c("regression","classification")){
        rlang::abort(
            message = paste0(
                "You chose a mode of: '",
                model_type,
                "' this is unsupported. Choose from either 'regression' or 'classification'."
            ),
            use_cli_format = TRUE
        )
    }

    if (!inherits(x = rsamp_obj, what = "rset") && !is.null(rsamp_obj)){
        rlang::abort(
            message = "The '.rsamp_obj' argument must either be NULL or an object of
      calss 'rset'.",
            use_cli_format = TRUE
        )
    }

    if (!inherits(x = splits, what = "rsplit") && !is.null(splits)){
        rlang::abort(
            message = "The '.splits_obj' argument must either be NULL or an object of
      class 'rsplit'",
            use_cli_format = TRUE
        )
    }

    # Set default metric set ----
    if (model_type == "classification"){
        ms <- healthyR.ai::hai_default_classification_metric_set()
    } else {
        ms <- healthyR.ai::hai_default_regression_metric_set()
    }

    # Get splits if not then create
    if (is.null(splits)){
        splits <- rsample::initial_split(data = data_tbl)
    } else {
        splits <- splits
    }

    # Tune/Spec ----
    if (.tune){
        # Model Specification
        model_spec <- parsnip::nearest_neighbor(
            neighbors = tune::tune(),
            weight_func = tune::tune(),
            dist_power = tune::tune()
        )
    } else {
        model_spec <- parsnip::nearest_neighbor()
    }

    # Model Specification ----
    model_spec <- model_spec %>%
        parsnip::set_mode(mode = model_type) %>%
        parsnip::set_engine(engine = "kknn")

    # Workflow ----
    wflw <- workflows::workflow() %>%
        workflows::add_recipe(rec_obj) %>%
        workflows::add_model(model_spec)

    # Tuning Grid ---
    if (.tune){

        # Make tuning grid
        tuning_grid_spec <- dials::grid_latin_hypercube(
            hardhat::extract_parameter_set_dials(model_spec),
            size = grid_size
        )

        # Cross validation object
        if (is.null(rsamp_obj)){
            cv_obj <- rsample::mc_cv(
                data = rsample::training(splits)
            )
        } else {
            cv_obj <- rsamp_obj
        }

        # Tune the workflow
        # Start parallel backed
        modeltime::parallel_start(num_cores)

        tuned_results <- wflw %>%
            tune::tune_grid(
                resamples = cv_obj,
                grid      = tuning_grid_spec,
                metrics   = ms
            )

        modeltime::parallel_stop()

        # Get the best result set by a specified metric
        best_result_set <- tuned_results %>%
            tune::show_best(metric = best_metric, n = 1)

        # Plot results
        tune_results_plt <- tuned_results %>%
            tune::autoplot() +
            ggplot2::theme_minimal() +
            ggplot2::geom_smooth(se = FALSE) +
            ggplot2::theme(legend.position = "bottom")

        # Make final workflow
        wflw_fit <- wflw %>%
            tune::finalize_workflow(
                tuned_results %>%
                    tune::show_best(metric = best_metric, n = 1)
            ) %>%
            parsnip::fit(rsample::training(splits))

    } else {
        wflw_fit <- wflw %>%
            parsnip::fit(rsample::training(splits))
    }

    # Return ----
    output <- list(
        recipe_info = rec_obj,
        model_info = list(
            model_spec  = model_spec,
            wflw        = wflw,
            fitted_wflw = wflw_fit,
            was_tuned   = ifelse(.tune, "tuned", "not_tuned")
        )
    )

    if (.tune){
        output$tuned_info = list(
            tuning_grid      = tuning_grid_spec,
            cv_obj           = cv_obj,
            tuned_results    = tuned_results,
            grid_size        = grid_size,
            best_metric      = best_metric,
            best_result_set  = best_result_set,
            tuning_grid_plot = tune_results_plt,
            plotly_grid_plot = plotly::ggplotly(tune_results_plt)
        )
    }

    attr(output, "function_type") <- "boilerplate"

    return(invisible(output))

}
