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

    terms <- recipes::ellipse_check(...)

    recipes::add_step(
        recipe,
        hai_step_trig_new(
            terms    = terms,
            trained  = trained,
            role     = role,
            options  = options,
            skip     = skip,
            id       = id
        )
    )
}

hai_step_trig_new <-
    function(terms, role, trained, options, skip, id) {
        recipes::step(
            subclass   = "trig_values",
            terms      = terms,
            role       = role,
            trained    = trained,
            options    = options,
            skip       = skip,
            id         = id
        )
    }

#' @export
prep.hai_step_trig <- function(x, training, info = NULL, ...) {

    col_names <- terms_select(x$terms, info = info)
    recipes::check_type(training[, col_names])

    # Lambda Calculation
    if (is.null(x$lambda[1])) {
        lambda_values <- rep(NA, length(col_names))
        names(lambda_values) <- col_names
    } else if (x$lambda[1] == "auto") {
        lambda_values <- training[, col_names] %>%
            purrr::map(auto_lambda)
    } else {
        lambda_values <- rep(x$lambda[1], length(col_names))
        names(lambda_values) <- col_names
    }

    hai_step_trig_new(
        terms           = x$terms,
        role            = x$role,
        trained         = TRUE,
        period          = x$period,
        skip            = x$skip,
        id              = x$id
    )
}

#' @export
bake.step_ts_clean <- function(object, new_data, ...) {

    col_names <- names(object$lambdas_trained)

    for (i in seq_along(object$lambdas_trained)) {

        # Handle "non-numeric" naming issue
        val_i <- object$lambdas_trained[i]
        if (!is.na(val_i)) {
            val_i <- as.numeric(val_i)
        }

        new_data[, col_names[i]] <- ts_clean_vec(
            x      = new_data %>% purrr::pluck(col_names[i]),
            period = object$period[1],
            lambda = val_i
        )
    }

    tibble::as_tibble(new_data)
}

#' @export
print.step_ts_clean <- function(x, width = max(20, options()$width - 35), ...) {
    cat("Time Series Outlier Cleaning on ", sep = "")
    printer(names(x$lambdas_trained), x$terms, x$trained, width = width)
    invisible(x)
}




#' @rdname step_ts_clean
#' @param x A `step_ts_clean` object.
#' @export
tidy.step_ts_clean <- function(x, ...) {
    if (is_trained(x)) {
        res <- tibble::tibble(
            terms  = names(x$lambdas_trained),
            lambda = as.numeric(x$lambdas_trained)
        )
    } else {
        term_names <- recipes::sel2char(x$terms)
        res <- tibble::tibble(
            terms  = term_names,
            lambda = rlang::na_dbl
        )
    }
    res$id <- x$id
    res
}

#' @rdname required_pkgs.timetk
#' @export
required_pkgs.step_ts_clean <- function(x, ...) {
    c("timetk")
}
