#' Compare Data Against Distributions
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details Get information on the empirical distribution of your data along with
#' generated densities of other distributions.
#'
#' @description This function will attempt to get some key information on the
#' data you pass to it. It will also automatically normalize the data from 0 to 1.
#' This will not change the distribution just it's scale in order to make sure
#' that many different types of distributions can be fit to the data, which
#' should help identify what the distribution of the passed data could be.
#'
#' @seealso
#'
#' @param .x The numeric vector to analyze.
#'
#' @examples
#'
#' @return
#'
#' @export
#'

hai_distribution_comparison_tbl <- function(.x, .distributions = c("gamma","beta")){

    # Tidyeval ----
    x_term  <- .x
    dl      <- as.vector(tolower(.distributions))

    # Parameters ----
    hskew   <- healthyR.ai::hai_skewness_vec(x_term)
    hkurt   <- healthyR.ai::hai_kurtosis_vec(x_term)
    mu      <- mean(x_term, na.rm = TRUE)
    std     <- stats::sd(x_term, na.rm = TRUE)
    minimum <- min(x_term, na.rm = TRUE)
    maximum <- max(x_term, na.rm = TRUE)
    med     <- stats::median(x_term, na.rm = TRUE)
    n       <- length(x_term)

    # Distribution Table and associate stats function
    dist_df <- tibble::tibble(
        distribution = dl,
        stats_func = dplyr::case_when(
            distribution == "normal" ~ "rnorm",
            distribution == "uniform" ~ "runif",
            distribution == "exponential" ~ "rexp",
            distribution == "logisitic" ~ "rlogis",
            distribution == "beta" ~ "rbeta",
            distribution == "lognormal" ~ "rlnorm",
            distribution == "gamma" ~ "rgamma",
            distribution == "weibull" ~ "rweibull",
            distribution == "chisquare" ~ "rchisq",
            distribution == "cauchy" ~ "rcauchy",
            distribution == "hypergeometric" ~ "rhyper",
            distribution == "f" ~ "rf",
            distribution == "poisson" ~ "rpois"
        )
    )

    # Was a distribution chosen unsupported?
    supported_distributions <- c("normal","uniform","exponential","logistic","beta",
                                 "lognormal","gamma","weibull","chisquare","cauchy",
                                 "hypergeometric","f","poisson")

    dist_unsupported <- dist_df %>%
        dplyr::mutate(dist_supported = distribution %in% supported_distributions) %>%
        dplyr::filter(dist_supported == FALSE)

    # Checks ----
    if(!is.numeric(x_term)){
        stop(call. = FALSE, ".x must be a numeric vector.")
    }

    if(exists("dist_unsupported") & nrow(dist_unsupported) > 1){
        print(dist_unsupported)
        rlang::abort("You entered a distribution that is unsupported")
    }

    # Make distributions ----
    dist_tbl <- dist_df %>%
        dplyr::mutate(
            dist_data = dplyr::case_when(
                stats_func == "rgamma" ~ list(stats::rgamma(n = n, shape = hskew, rate = hkurt)),
                stats_func == "rbeta"  ~ list(stats::rbeta(n = n, shape1 = hskew, shape2 = hkurt)),
                stats_func == "rnorm"  ~ list(stats::rnorm(n = n, mean = mu, sd = std)),
                stats_func == "runif"  ~ list(stats::runif(n = n, min = minimum, max = maximum)),
                stats_func == "rexp"   ~ list(stats::rexp(n = n, rate = hkurt)),
                stats_func == "rlogis" ~ list(stats::rlogis(n = n, location = hskew, scale = hkurt)),
                stats_func == "rlnorm" ~ list(stats::rlnorm(n = n, meanlog = log(mu), sdlog = log(std))),
                stats_func == "rweibull" ~ list(stats::rweibull(n = n, shape = hskew, scale = hkurt)),
                stats_func == "rchisq"   ~ list(stats::rchisq(n = n, df = hskew)),
                stats_func == "rcauchy"  ~ list(stats::rcauchy(n = n, location = hskew, scale = hkurt)),
                stats_func == "rhyper"   ~ list(stats::rhyper(nn = n, m = n, n = n, k = n) %>%
                                                  healthyR.ai::hai_scale_zero_one_vec()),
                stats_func == "rf"       ~ list(stats::rf(n = n, df1 = hskew, df2 = hskew) %>%
                                              healthyR.ai::hai_scale_zero_one_vec()),
                stats_func == "rpois"    ~ list(stats::rpois(n = n, lambda = hskew) %>%
                                                 healthyR.ai::hai_scale_zero_one_vec())
            )
        ) %>%
        dplyr::group_by(distribution) %>%
        dplyr::mutate(density_data = list(density(unlist(dist_data)))) %>%
        dplyr::ungroup() %>%
        dplyr::select(-stats_func)

    # Add empirical data and density to tibble
    emp_dens_tbl <- tibble::tibble(
        distribution = "empirical",
        dist_data    = list(x_term),
        density_data = list(density(x_term))
    )

    dist_final_tbl <- rbind(dist_tbl, emp_dens_tbl)

    # Add Class of hai_dist_tbl
    class(dist_final_tbl) <- c("tbl_df","tbl","data.frame","hai_dist_tbl")

    # Return ----
    return(dist_final_tbl)

}
