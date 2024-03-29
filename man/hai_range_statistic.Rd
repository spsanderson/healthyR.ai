% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/hai-range-statistic.R
\name{hai_range_statistic}
\alias{hai_range_statistic}
\title{Get the range statistic}
\usage{
hai_range_statistic(.x)
}
\arguments{
\item{.x}{A numeric vector}
}
\value{
A single number, the range statistic
}
\description{
Takes in a numeric vector and returns back the range of that
vector
}
\details{
Takes in a numeric vector and returns the range of that vector using
the \code{diff} and \code{range} functions.
}
\examples{
hai_range_statistic(seq(1:10))

}
\author{
Steven P. Sandeson II, MPH
}
