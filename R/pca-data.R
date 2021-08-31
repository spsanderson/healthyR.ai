#' Perform PCA
#'
#' @family Data Wrangling
#' @family Data Recipes
#' @family Dimension Reduction
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @seealso \url{https://recipes.tidymodels.org/reference/step_pca.html}
#'
#' @description
#' This is a simple function that will perform PCA analysis on a passed recipe.
#'
#' @details
#' This is a simple wrapper around some recipes functions to perform a PCA on a
#' given recipe. This function will output a list and return it invisible.
#' All of the components of the analysis will be returned in a list as their own
#' object that can be selected individually. A scree plot is also included. The
#' items that get returned are:
#'   1. pca_transform - This is the pca recipe.
#'   2. variable_loadings
#'   3. variable_variance
#'   4. pca_estimates
#'   5. pca_juiced_estimates
#'   6. pca_baked_data
#'   7. pca_variance_df
#'   8. pca_variance_scree_plt
#'   9. pca_rotation_df
#'
#' @param .recipe_object The recipe object you want to pass.
#' @param .data The full data set that is used in the original recipe object passed
#' into `.recipe_object` in order to obtain the baked data of the transform.
#' @param .threshold A number between 0 and 1. A fraction of the total variance
#' that should be covered by the components.
#'
#' @examples
#' suppressPackageStartupMessages(library(timetk))
#' suppressPackageStartupMessages(library(dplyr))
#' suppressPackageStartupMessages(library(purrr))
#' suppressPackageStartupMessages(library(healthyR.data))
#' suppressPackageStartupMessages(library(rsample))
#' suppressPackageStartupMessages(library(recipes))
#' suppressPackageStartupMessages(library(ggplot2))
#'
#' data_tbl <- healthyR_data %>%
#'     select(visit_end_date_time) %>%
#'     summarise_by_time(
#'         .date_var = visit_end_date_time,
#'         .by       = "month",
#'         value     = n()
#'     ) %>%
#'     set_names("date_col","value") %>%
#'     filter_by_time(
#'         .date_var = date_col,
#'         .start_date = "2013",
#'         .end_date = "2020"
#'     )
#'
#' splits <- initial_split(data = data_tbl, prop = 0.8)
#'
#' rec_obj <- recipe(value ~ ., training(splits)) %>%
#'     step_timeseries_signature(date_col) %>%
#'     step_rm(matches("(iso$)|(xts$)|(hour)|(min)|(sec)|(am.pm)"))
#'
#' output_list <- pca_your_recipe(rec_obj, .data = data_tbl)
#' output_list$pca_variance_scree_plt
#'
#' @return
#' A list object with several components.
#'
#' @export
#'

pca_your_recipe <- function(.recipe_object, .data, .threshold = 0.75){

    # Variables ----
    rec_obj       <- .recipe_object
    threshold_var <- .threshold

    # * Checks ----
    # Is the .recipe_object in fact a class of recipe?
    if (!class(rec_obj) == "recipe"){
        stop(call. = FALSE, "You must supply an object of class recipe.")
    }

    if(!is.numeric(threshold_var) | (threshold_var < 0) | (threshold_var > 1)){
        stop(call. = FALSE, "(.threshold) needs to be a number between 0 and 1.")
    }

    if(!is.data.frame(.data)){
        stop(call. = FALSE, "(.data) must be supplied from the original recipe.")
    }

    # * Data ----
    data_tbl <- .data

    # * Recipe steps ----
    pca_transform <- rec_obj %>%
        recipes::step_center(recipes::all_numeric()) %>%
        recipes::step_scale(recipes::all_numeric()) %>%
        recipes::step_nzv(recipes::all_numeric()) %>%
        recipes::step_pca(
            recipes::all_numeric_predictors(),
            threshold = threshold_var,
            options = list(
                retx   = TRUE
            )
        )

    # * List items ----
    pca_step_number   <- max(recipes::tidy(pca_transform)$number)
    pca_estimates     <- recipes::prep(pca_transform)
    juiced_estimates  <- recipes::juice(pca_estimates)
    variable_loadings <- recipes::tidy(pca_estimates, type = "coef", number = pca_step_number)
    variable_variance <- recipes::tidy(pca_estimates, type = "variance", number = pca_step_number)
    pca_baked_data    <- recipes::bake(pca_estimates, data_tbl)
    pca_sdev          <- pca_estimates$steps[[pca_step_number]]$res$sdev
    pca_rotation_df   <- pca_estimates$steps[[pca_step_number]]$res$rotation %>%
        dplyr::as_tibble()

    # * Scree Plot
    percent_variation <- pca_sdev^2 / sum(pca_sdev^2)
    var_df <- data.frame(PC = paste0("PC", 1:length(pca_sdev)),
                         var_explained = percent_variation,
                         stringsAsFactors = FALSE) %>%
        dplyr::as_tibble() %>%
        dplyr::mutate(var_pct_txt = round(var_explained, 4) %>%
                          scales::percent(accuracy = 0.01)) %>%
        dplyr::mutate(cum_var_pct = cumsum(var_explained)/sum(var_explained)) %>%
        dplyr::mutate(cum_var_pct_txt = cum_var_pct %>%
                          scales::percent(accuracy = 0.01)) %>%
        dplyr::mutate(ou_threshold = ifelse(cum_var_pct <= threshold_var,"Under","Over") %>%
                          forcats::as_factor())
    var_plt <- var_df %>%
        dplyr::mutate(PC = forcats::fct_inorder(PC)) %>%
        ggplot2::ggplot(
            ggplot2::aes(
                x      = PC
                , y    = var_explained
                , fill = ou_threshold
            )
        ) +
        ggplot2::geom_col() +
        ggplot2::scale_y_continuous(labels = scales::percent) +
        tidyquant::scale_fill_tq() +
        tidyquant::theme_tq() +
        ggplot2::labs(
            title = "PCA Scree Plot"
            , subtitle = "Typically the first red column is your last PC"
            , x = "Principal Component"
            , y = "% Variance Explained"
            , fill = "Threshold Indicator"
        )
    # * Build List ----
    output_list <- list(
        pca_transform          = pca_transform,
        variable_loadings      = variable_loadings,
        variable_variance      = variable_variance,
        pca_estimates          = pca_estimates,
        pca_juiced_estimates   = juiced_estimates,
        pca_baked_data         = pca_baked_data,
        pca_variance_df        = var_df,
        pca_variance_scree_plt = var_plt,
        pca_rotation_df        = pca_rotation_df
    )

    # * Return ----
    return(invisible(output_list))
}
