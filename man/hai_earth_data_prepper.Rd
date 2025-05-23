% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data-prep-earth.R
\name{hai_earth_data_prepper}
\alias{hai_earth_data_prepper}
\title{Prep Data for Earth - Recipe}
\usage{
hai_earth_data_prepper(.data, .recipe_formula)
}
\arguments{
\item{.data}{The data that you are passing to the function. Can be any type
of data that is accepted by the \code{data} parameter of the \code{recipes::reciep()}
function.}

\item{.recipe_formula}{The formula that is going to be passed. For example
if you are using the \code{diamonds} data then the formula would most likely be something
like \code{price ~ .}}
}
\value{
A recipe object
}
\description{
Automatically prep a data.frame/tibble for use in the Earth algorithm.
}
\details{
This function will automatically prep your data.frame/tibble for
use in the Earth algorithm. The Earth algorithm is for classification and
regression.

This function will output a recipe specification.
}
\examples{
library(ggplot2)
library(tibble)

# Regression
hai_earth_data_prepper(.data = diamonds, .recipe_formula = price ~ .)
reg_obj <- hai_earth_data_prepper(diamonds, price ~ .)
get_juiced_data(reg_obj)

# Classification
Titanic <- as_tibble(Titanic)

hai_earth_data_prepper(Titanic, Survived ~ .)
cla_obj <- hai_earth_data_prepper(Titanic, Survived ~ .)
get_juiced_data(cla_obj)

}
\seealso{
\url{http://uc-r.github.io/mars}

Other Preprocessor: 
\code{\link{hai_c50_data_prepper}()},
\code{\link{hai_cubist_data_prepper}()},
\code{\link{hai_data_impute}()},
\code{\link{hai_data_poly}()},
\code{\link{hai_data_scale}()},
\code{\link{hai_data_transform}()},
\code{\link{hai_data_trig}()},
\code{\link{hai_glmnet_data_prepper}()},
\code{\link{hai_knn_data_prepper}()},
\code{\link{hai_ranger_data_prepper}()},
\code{\link{hai_svm_poly_data_prepper}()},
\code{\link{hai_svm_rbf_data_prepper}()},
\code{\link{hai_xgboost_data_prepper}()}

Other Earth: 
\code{\link{hai_auto_earth}()}
}
\author{
Steven P. Sanderson II, MPH
}
\concept{Earth}
\concept{Preprocessor}
