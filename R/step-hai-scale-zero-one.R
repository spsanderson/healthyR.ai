#' Recipes Date Scale to Zero and One
#'
#' @family Recipes
#'
#' @description
#' `step_hai_scale_zero_one` creates a a *specification* of a recipe
#'  step that will convert numeric data into from a time series into its
#'  velocity.
#'
#' @param recipe A recipe object. The step will be added to the
#'  sequence of operations for this recipe.
#' @param ... One or more selector functions to choose which
#'  variables that will be used to create the new variables. The
#'  selected variables should have class `numeric`
#' @param trained A logical to indicate if the quantities for
#'  preprocessing have been estimated.
#' @param role For model terms created by this step, what analysis
#'  role should they be assigned?. By default, the function assumes
#'  that the new variable columns created by the original variables
#'  will be used as predictors in a model.
#' @param columns A character string of variables that will be
#'  used as inputs. This field is a placeholder and will be
#'  populated once `recipes::prep()` is used.
#' @param skip A logical. Should the step be skipped when the recipe is
#'  baked by bake.recipe()? While all operations are baked when prep.recipe()
#'  is run, some operations may not be able to be conducted on new data
#'  (e.g. processing the outcome variable(s)). Care should be taken when
#'  using skip = TRUE as it may affect the computations for subsequent operations.
#' @param id A character string that is unique to this step to identify it.
#'
#' @return For `step_hai_scale_zero_one`, an updated version of recipe with
#'  the new step added to the sequence of existing steps (if any).
#'
#'  Main Recipe Functions:
#'  - `recipes::recipe()`
#'  - `recipes::prep()`
#'  - `recipes::bake()`
#'
#'
#' @details
#'
#' __Numeric Variables__
#'  Unlike other steps, `step_hai_scale_zero_one` does *not*
#'  remove the original numeric variables. [recipes::step_rm()] can be
#'  used for this purpose.
#'
#' @examples
#' suppressPackageStartupMessages(library(dplyr))
#' suppressPackageStartupMessages(library(recipes))
#'
#' data_tbl <- data.frame(a = rnorm(200, 3, 1), b = rnorm(200, 2, 2))
#'
#' # Create a recipe object
#' rec_obj <- recipe(a ~ ., data = data_tbl) %>%
#'   step_hai_scale_zero_one(b)
#'
#' # View the recipe object
#' rec_obj
#'
#' # Prepare the recipe object
#' prep(rec_obj)
#'
#' # Bake the recipe object - Adds the Time Series Signature
#' bake(prep(rec_obj), data_tbl)
#'
#' rec_obj %>% prep() %>% juice()
#'
#' @export
#'
#' @importFrom recipes prep bake rand_id
