#' Data Preprocessor - Transformation Functions
#'
#' @family Data Recipes
#' @family Preprocessor
#'
#' @keywords internal
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @description
#' Takes in a recipe and will perform the desired transformation on the selected
#' varialbe(s) using a selected recipe. To call the desired transformation
#' recipe use a quoted argument like "boxcos", "bs" etc. This function
#' is not exported but may be called via the ::: method.
#'
#' @details
#' This function will get your data ready for processing with many types of ml/ai
#' models.
#'
#' This is intended to be used inside of the data processor and
#' therefore is an internal function. This documentation exists to explain the process
#' and help the user understand the parameters that can be set in the pre-processor function.
#'
#' [recipes::step_BoxCox()]
#' @seealso \url{https://recipes.tidymodels.org/reference/step_BoxCox.html}
#'
#' [recipes::step_bs()]
#' @seealso \url{https://recipes.tidymodels.org/reference/step_bs.html}
#'
#' [recipes::step_log()]
#' @seealso \url{https://recipes.tidymodels.org/reference/step_log.html}
#'
#' [recipes::step_logit()]
#' @seealso \url{https://recipes.tidymodels.org/reference/step_logit.html}
#'
#' [recipes::step_ns()]
#' @seealso \url{https://recipes.tidymodels.org/reference/step_ns.html}
#'
#' [recipes::step_relu()]
#' @seealso \url{https://recipes.tidymodels.org/reference/step_relu.html}
#'
#' [recipes::step_sqrt()]
#' @seealso \url{https://recipes.tidymodels.org/reference/step_sqrt.html}
#'
#' [recipes::step_YeoJohnson()]
#' @seealso \url{https://recipes.tidymodels.org/reference/step_YeoJohnson.html}
#'
#' @param .recipe_object The data that you want to process
#' @param ... One or more selector functions to choose variables to be imputed.
#' When used with imp_vars, these dots indicate which variables are used to
#' predict the missing data in each variable. See selections() for more details
#' @param .type_of_scale This is a quoted argument and can be one of the following:
#' -  "boxcox"
#' -  "bs"
#' -  "log"
#' -  "logit"
#' -  "ns"
#' -  "relu"
#' -  "sqrt"
#' -  "yeojohnson
#' @param .bc_limits A length 2 numeric vector defining the range to compute the
#' transformation parameter lambda.
#' @param .bc_num_unique An integer to specify minimum required unique values to
#' evaluate for a transformation
#' @param .bs_deg_free The degrees of freedom for the spline. As the degrees of
#' freedom for a spline increase, more flexible and complex curves can be
#' generated. When a single degree of freedom is used, the result is a rescaled
#' version of the original data.
#' @param .bs_degree Degree of polynomial spline (integer).
#' @param .log_base A numberic value for the base.
#' @param .log_offset An optional value to add to the data prior to logging (to avoid log(0))
#' @param .logit_offset A numberic value to modify values ofthe columns that are
#' either one or zero. They are modifed to be `x - offset` or `offset` respectively.
#' @param .ns_deg_free The degrees of freedom for the natural spline. As the
#' degrees of freedom for a natural spline increase, more flexible and complex
#' curves can be generated. When a single degree of freedom is used, the result
#' is a rescaled version of the original data.
#' @param .rel_shift A numeric value dictating a translation to apply to the data.
#' @param .rel_reverse A logical to indicate if theleft hinge should be used as
#' opposed to the right hinge.
#' @param .rel_smooth A logical indicating if hte softplus function, a smooth
#' approximation to the rectified linear transformation, should be used.
#' @param .yj_limits A length 2 numeric vector defining the range to compute the
#' transformation parameter lambda.
#' @param .yj_num_unique An integer where data that have less possible values
#' will not be evaluated for a transformation.
#'
#' @examples
#' suppressPackageStartupMessages(library(dplyr))
#' suppressPackageStartupMessages(library(recipes))
#'
#' date_seq <- seq.Date(from = as.Date("2013-01-01"), length.out = 100, by = "month")
#' val_seq  <- rep(rnorm(10, mean = 6, sd = 2), times = 10)
#' df_tbl   <- tibble(
#'     date_col = date_seq,
#'     value    = val_seq
#' )
#'
#' rec_obj <- recipe(value ~., df_tbl)
#'
#' healthyR.ai:::hai_data_transform(
#'     .recipe_object = rec_obj,
#'     value,
#'     .type_of_scale = "log"
#' )$scale_rec_obj %>%
#'     get_juiced_data()
#'
#' @return
#' A list object
#'

hai_data_transform <-  function(.recipe_object = NULL, ..., .type_of_scale = "log"
                                , .bc_limits = c(-5,5), .bc_num_unique = 5
                                , .bs_deg_free = NULL, .bs_degree = 3
                                , .log_base = exp(1), .log_offset = 0
                                , .logit_offset = 0, .ns_deg_free = 2
                                , .rel_shift = 0, .rel_reverse = FALSE, .rel_smooth = FALSE
                                , .yj_limits = c(-5,5), .yj_num_unique = 5){

    # Make sure a recipe was passed
    if(is.null(.recipe_object)){
        rlang::abort("`.recipe_object` must be passed, please add.")
    } else {
        rec_obj <- .recipe_object
    }

    # * Parameters ----
    terms        <- rlang::enquos(...)
    scale_type   <- as.character(.type_of_scale)

    # * Checks ----
    if(!tolower(scale_type) %in% c(
        "boxcox","bs","log","logit","ns","relu","sqrt","yeojohnson"
    )
    ){
        stop(call. = FALSE, "(.type_of_scale) is not implemented. Please choose
             from 'boxcox','bs','log','logit','ns','relu','sqrt','yeojohnson'")
    }

    # If Statement to get the recipe desired ----
    if(scale_type == "boxcox"){
        scale_obj <- recipes::step_BoxCox(
            recipe     = rec_obj,
            limits     = .bc_limits,
            num_unique = .bc_num_unique,
            !!! terms
        )
    } else if(scale_type == "bs"){
        scale_obj <- recipes::step_bs(
            recipe   = rec_obj,
            deg_free = .bs_deg_free,
            degree   = .bs_degree,
            !!! terms
        )
    } else if(scale_type == "log"){
        scale_obj <- recipes::step_log(
            recipe  = rec_obj,
            base    = .log_base,
            offset  = .log_offset,
            !!! terms
        )
    } else if(scale_type == "logit"){
        scale_obj <- recipes::step_logit(
            recipe = rec_obj,
            offset = .logit_offset,
            !!! terms
        )
    } else if(scale_type == "ns"){
        scale_obj <- recipes::step_ns(
            recipe   = rec_obj,
            deg_free = .ns_deg_free,
            !!! terms
        )
    } else if(scale_type == "relu"){
        scale_obj <- recipes::step_relu(
            recipe  = rec_obj,
            shift   = .rel_shift,
            reverse = .rel_reverse,
            smooth  = .rel_smooth,
            !!! terms
        )
    } else if(scale_type == "sqrt"){
        scale_obj <- recipes::step_sqrt(
            recipe = rec_obj,
            !!! terms
        )
    } else if(scale_type == "yeojohnson"){
        scale_obj <- recipes::step_YeoJohnson(
            recipe     = rec_obj,
            limits     = .yj_limits,
            num_unique = .yj_num_unique,
            !!! terms
        )
    }

    # * Recipe List ---
    output <- list(
        rec_base      = rec_obj,
        scale_rec_obj = scale_obj
    )

    # * Return ----
    return(output)

}
