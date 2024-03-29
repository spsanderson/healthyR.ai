#' Recipes Step Hyperbolic Generator
#'
#' @family Recipes
#'
#' @description
#' `step_hai_hyperbolic` creates a a *specification* of a recipe
#'  step that will convert numeric data into either a 'sin', 'cos', or 'tan'
#'  feature that can aid in machine learning.
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
#' @param scale_type A character string of a scaling type, one of "sin","cos","tan" or "sincos"
#' @param skip A logical. Should the step be skipped when the recipe is
#'  baked by bake.recipe()? While all operations are baked when prep.recipe()
#'  is run, some operations may not be able to be conducted on new data
#'  (e.g. processing the outcome variable(s)). Care should be taken when
#'  using skip = TRUE as it may affect the computations for subsequent operations.
#' @param id A character string that is unique to this step to identify it.
#'
#' @return For `step_hai_hyperbolic`, an updated version of recipe with
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
#'  Unlike other steps, `step_hai_hyperbolic` does *not*
#'  remove the original numeric variables. [recipes::step_rm()] can be
#'  used for this purpose.
#'
#' @examples
#' suppressPackageStartupMessages(library(dplyr))
#' suppressPackageStartupMessages(library(recipes))
#'
#' len_out <- 10
#' by_unit <- "month"
#' start_date <- as.Date("2021-01-01")
#'
#' data_tbl <- tibble(
#'   date_col = seq.Date(from = start_date, length.out = len_out, by = by_unit),
#'   a = rnorm(len_out),
#'   b = runif(len_out)
#' )
#'
#' # Create a recipe object
#' rec_obj <- recipe(a ~ ., data = data_tbl) %>%
#'   step_hai_hyperbolic(b, scale_type = "sin") %>%
#'   step_hai_hyperbolic(b, scale_type = "cos")
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
#' rec_obj %>% get_juiced_data()
#'
#' @export
#'
#' @importFrom recipes prep bake rand_id

step_hai_hyperbolic <- function(recipe,
                                ...,
                                role = "predictor",
                                trained = FALSE,
                                columns = NULL,
                                scale_type = c("sin", "cos", "tan", "sincos"),
                                skip = FALSE,
                                id = rand_id("hai_hyperbolic")) {
  terms <- recipes::ellipse_check(...)
  funcs <- c("sin", "cos", "tan", "sincos")
  if (!(scale_type %in% funcs)) {
    rlang::abort("`func` should be either `sin`, `cos`, `sincos` or `tan`")
  }

  recipes::add_step(
    recipe,
    step_hai_hyperbolic_new(
      terms      = terms,
      role       = role,
      trained    = trained,
      columns    = columns,
      scale_type = scale_type,
      skip       = skip,
      id         = id
    )
  )
}

step_hai_hyperbolic_new <-
  function(terms, role, trained, columns, scale_type, skip, id) {
    recipes::step(
      subclass   = "hai_hyperbolic",
      terms      = terms,
      role       = role,
      trained    = trained,
      columns    = columns,
      scale_type = scale_type,
      skip       = skip,
      id         = id
    )
  }

#' @export
prep.step_hai_hyperbolic <- function(x, training, info = NULL, ...) {
  col_names <- recipes::recipes_eval_select(x$terms, training, info)
  recipes::check_type(training[, col_names])

  # value_data <- info[info$variable %in% col_names, ]
  #
  # if (any(value_data$type != "numeric")) {
  #   rlang::abort(
  #     paste0(
  #       "All variables for `step_hai_hyperbolic` must be `numeric`",
  #       "`integer` `double` classes."
  #     )
  #   )
  # }

  step_hai_hyperbolic_new(
    terms      = x$terms,
    role       = x$role,
    trained    = TRUE,
    columns    = col_names,
    scale_type = x$scale_type,
    skip       = x$skip,
    id         = x$id
  )
}

#' @export
bake.step_hai_hyperbolic <- function(object, new_data, ...) {
  make_call <- function(col, scale_type) {
    rlang::call2(
      "hai_hyperbolic_vec",
      .x = rlang::sym(col),
      .scale_type = scale_type,
      .ns = "healthyR.ai"
    )
  }

  grid <- expand.grid(
    col = object$columns,
    scale_type = object$scale_type,
    stringsAsFactors = FALSE
  )

  calls <- purrr::pmap(.l = list(grid$col, grid$scale_type), make_call)

  # Column Names
  newname <- paste0("hyperbolic_", grid$col, "_", grid$scale_type)
  calls <- recipes::check_name(calls, new_data, object, newname, TRUE)

  tibble::as_tibble(dplyr::mutate(new_data, !!!calls))
}

#' @export
print.step_hai_hyperbolic <-
  function(x, width = max(20, options()$width - 35), ...) {
    title <- "Hyperbolic Transformation on "
    recipes::print_step(
      x$columns, x$terms, x$trained,
      width = width, title = title
    )
    invisible(x)
  }

#' Requited Packages
#' @rdname required_pkgs.healthyR.ai
#' @keywords internal
#' @return A character vector
#' @param x A recipe step
# @noRd
#' @export
required_pkgs.step_hai_hyperbolic <- function(x, ...) {
  c("healthyR.ai")
}
