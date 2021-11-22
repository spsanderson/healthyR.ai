#' Augment Polynomial Features
#'
#' @family Augment Function
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @description
#' This function takes in a data table and a predictor column. A user can either create
#' their own formula using the `.formula` parameter or, if they leave the default of
#' `NULL` then the user must enter a `.degree` __AND__ `.pred_col` column.
#'
#' @details
#' A valid data.frame/tibble must be passed to this function. It is required that
#' a user either enter a `.formula` or a `.degree` __AND__ `.pred_col` otherwise this
#' function will stop and error out.
#'
#' Under the hood this function will create a [stats::poly()] function if the
#' `.formula` is left as `NULL`. For example:
#' -  .formula = A ~ .^2
#' -  OR .degree = 2, .pred_col = A
#'
#' There is also a parameter `.new_col_prefix` which will add a character string
#' to the column names so that they are easily identified further down the line.
#' The default is 'nt_'
#'
#' @param .data The data being passed that will be augmented by the function.
#' @param .pred_col This is passed [rlang::enquo()] to capture the vector that you
#' designate as the 'y' column.
#' @param .formula This should be a valid formula like 'y ~ .^2' or NULL.
#' @param .degree This should be an integer and is used to set the degree in the
#' poly function. The degree must be less than the unique data points or it will
#' error out.
#' @param .new_col_prefix The default is "nt_" which stands for "new_term". You can
#' set this to whatever you like, as long as it is a quoted string.
#'
#' @examples
#' suppressPackageStartupMessages(library(dplyr))
#' data_tbl <- data.frame(
#'   A = c(0,2,4),
#'   B = c(1,3,5),
#'   C = c(2,4,6)
#' )
#'
#' hai_polynomial_augment(.data = data_tbl, .pred_col = A, .degree = 2, .new_col_prefix = "n")
#' hai_polynomial_augment(.data = data_tbl, .formula = A ~ .^2, .degree = 1)
#'
#' @return
#' An augmented tibble
#'
#' @export
#'

hai_polynomial_augment <- function(.data, .formula = NULL, .pred_col = NULL
                                   , .degree = 1, .new_col_prefix = "nt_"){

    # Tidyeval ----
    f <- .formula
    d <- base::as.integer(.degree)
    pred_col_var_expr <- rlang::enquo(.pred_col)
    ncp <- .new_col_prefix

    # Manipulate ----
    # Ensure that the 'y' column is the first column of the data.frame/tibble
    data_tbl <- .data %>%
        tibble::as_tibble() %>%
        dplyr::select({{ pred_col_var_expr }}, dplyr::everything())

    # Checks ----
    if(!is.null(f)){
        f = stats::as.formula(f)
    } else if(
        !rlang::quo_is_missing(pred_col_var_expr) &
        !rlang::quo_is_null(pred_col_var_expr) &
        !is.null(d) &
        is.integer(d)
    ){
        f = stats::reformulate(
            paste0(
                'poly(',
                colnames(data_tbl[-1]),
                ', ',
                d,
                ')'
            )
            , response = rlang::as_name(pred_col_var_expr)
        )
    } else {
        stop(
            "There is an issue with how you entered your parameters. Please fix.",
            "\nYou have .formula  = ", .formula,
            "\nYou have .pred_col = ", .pred_col,
            "\nYou have .degree   = ", .degree,
            "\nIf you have .formula = NULL, then you must set .pred_col AND .degree."
        )
    }

    if(!is.character(ncp)){
        stop(".new_col_prefix must be a quoted character string")
    } else {
        ncp <- ncp
    }

    # Augment ----
    mm    <- stats::model.matrix(f, data = data_tbl)
    mm_df <- mm %>% base::as.data.frame() %>% janitor::clean_names()

    new_mm_col_names <- paste0(ncp, names(mm_df))
    colnames(mm_df)  <- new_mm_col_names

    data_tbl <- cbind(data_tbl, mm_df) %>% tibble::as_tibble()

    # Return ----
    message("The formula used is: ", deparse(f))
    return(data_tbl)
}

