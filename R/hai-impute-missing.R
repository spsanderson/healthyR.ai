#' Data Preprocessor - Imputation
#'
#' @family Imputation
#' @family Data Recipes
#' @family Preprocessor
#'
#' @keywords internal
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @description
#' Takes in a recipe and will impute missing values using a selected recipe.
#' To call the recipe use a quoted argument like "median" or "bagged". This function
#' is not exported but may be called via the ::: method.
#'
#' @details
#' This function will get your data ready for processing with many types of ml/ai
#' models.
#'
#' This is intended to be used inside of the [healthyR.ai::hai_data_preprocessor()] and
#' therefore is an internal function. This documentation exists to explain the process
#' and help the user understand the parameters that can be set in the preprocessor function.
#'
#' The first function used is [recipes::step_impute_bag()]
#'
#' __Main Recipes Imputation Section:__
#' @seealso \url{https://recipes.tidymodels.org/reference/index.html#section-step-functions-imputation/}
#'
#' step_impute_bag
#' @seealso \url{https://recipes.tidymodels.org/reference/step_impute_bag.html}
#'
#' step_impute_knn
#' @seealso \url{https://recipes.tidymodels.org/reference/step_impute_knn.html}
#'
#' @param .recipe_object The data that you want to process
#' @param ... One or more selector functions to choose variables to be imputed.
#' When used with imp_vars, these dots indicate which variables are used to
#' predict the missing data in each variable. See selections() for more details
#' @param .impute_vars_with A call to imp_vars to specify which variables are
#' used to impute the variables that can include specific variable names
#' separated by commas or different selectors (see selections()). If a column is
#' included in both lists to be imputed and to be an imputation predictor,
#' it will be removed from the latter and not used to impute itself.
#' @param .seed_value To make results reproducible, set the seed.
#' @param .number_of_trees This is used for the [recipes::step_impute_bag()] trees
#' parameter. This should be an integer.
#' @param .type_of_imputation This is a quoted argument and can be one of the following:
#' -  "bagged"
#' -  "knn"
#' -  "linear"
#' -  "lower"
#' -  "mean"
#' -  "median"
#' -  "mode"
#' -  "roll"
#' @param .neighbors This should be filled in with an integer value if `.type_of_imputation`
#' selected is "knn".
#' @param .mean_trim This should be filled in with a fraction if `.type_of_imputation`
#' selected is "mean".
#' @param .roll_statistic This should be filled in with a single unquoted function
#' that takes with it a single argument such as mean. This should be filled in
#' if `.type_of_imputation` selected is "roll".
#' @param .roll_window This should be filled in with an integer value if `.type_of_imputation`
#' selected is "roll".
#'
#' @examples
#' library(healthyR.data)
#' library(dplyr)
#'
#' data_tbl <- healthyR_data%>%
#'    filter(ip_op_flag == "I") %>%
#'    filter(payer_grouping != "Medicare B") %>%
#'    filter(payer_grouping != "?") %>%
#'    select(service_line, payer_grouping) %>%
#'    mutate(record = 1) %>%
#'    as_tibble()
#'
#' hai_data_impute()
#'
#' @return
#' A processed data.frame/tibble.
#'

hai_data_impute <- function(.recipe_object = NULL, ...,
                            .impute_vars_with = imp_vars(all_predictors()),
                            .seed_value = 123, .type_of_imputation = "mean",
                            .number_of_trees = 25, .neighbors = 5, .mean_trim = 0,
                            .roll_statistic = median, .roll_window = 5){

    # Make sure a recipe was passed
    if(is.null(.recipe_object)){
        rlang::abort("`.recipe_object` must be passed, please add.")
    } else {
        rec_obj <- .recipe_object
    }

    # * Parameters ----
    terms       <- rlang::enquos(...)
    impute_with <- .impute_vars_with
    seed_value  <- as.integer(.seed_value)
    impute_type <- as.character(.type_of_imputation)
    trees       <- as.integer(.number_of_trees)
    neighbors   <- as.integer(.neighbors)
    mean_trim   <- as.numeric(.mean_trim) # 1 >= trim >= 0
    roll_stat   <- substitute(.roll_statistic)
    roll_window <- as.integer(.roll_window)

    # * Checks ----
    if (is.null(impute_with)) {
        rlang::abort("`impute_with` Needs some variables please.")
    }

    if(!is.null(seed_value) | !is.integer(seed_value)){
        stop(call. = FALSE, "(.seed_value) must either be NULL or an integer.")
    }

    if(!is.character(impute_type)){
        stop(call. = FALSE, "(.type_of_imputation) must be a quoted function that takes a single
             parameter, i.e. mean or median.")
    }

    if(!tolower(impute_type) %in% c(
        "bagged","knn","linear","lower","mean","median","mode","roll"
        )
    ){
        stop(call. = FALSE, "(.type_of_imputattion) is not implemented. Please choose
             from 'bagged','knn','linear','lower','mean','median','mode','roll'")
    }

    if(!is.integer(trees) | !is.integer(neighbors) | !is.integer(roll_window)){
        stop(call. = FALSE, "The parameters of (.trees), (.neighbors), and (.roll_window) must
             be integers.")
    }

    if(!is.numeric(mean_trim) | (mean_trim > 1) | (mean_trim < 0)){
        stop(call. = FALSE, "(.mean_trim) must be a fraction between 0 and 1, such as 0.25")
    }

    # Is the .recipe_object in fact a class of recipe?
    if (!class(rec_obj) == "recipe"){
        stop(call. = FALSE, "You must supply an object of class recipe.")
    }

    # * if statement to run the desired type of imputation
    if(impute_type == "bagged"){
        imp_obj <- recipes::step_impute_bag(
            recipe      = rec_obj,
            terms,
            impute_with = impute_with,
            trees       = trees,
            seed_val    = seed_value
        )
    }

    # * Return ---
    return(rec_obj)
}
