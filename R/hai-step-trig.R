#' Data Preprocessor - Step Trigonometry
#'
#' @family Data Recipes
#' @family Preprocessor
#'
#' @keywords internal
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @description
#' Takes in a recipe and will add sin, cos and tan transformed values. This function
#' is not exported but may be called via the ::: method.
#'
#' @details
#' This function will get your data ready for processing with many types of ml/ai
#' models.
#'
#' This is intended to be used inside of the [healthyR.ai::hai_data_preprocessor()] and
#' therefore is an internal function. This documentation exists to explain the process
#' and help the user understand the parameters that can be set in the pre-processor function.
#'
#' @return
#' A recipe object
#'
#' @export
#'
hai_step_trig <- function(
    recipe,
    ...,
    role = NA,
    trained = FALSE,
    skip = FALSE,
    id = rand_id("trigonometry")
) {

}
