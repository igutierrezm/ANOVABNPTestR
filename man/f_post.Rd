% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/f_post.R
\name{F_post}
\alias{F_post}
\title{Return the posterior predictive cdf}
\usage{
F_post(fit)
}
\arguments{
\item{fit}{An object of class anova_bnp_model.}
}
\value{
A tibble with the following variables:
\itemize{
\item group the group id.
\item y the value of the response variable.
\item the posterior predictive cdf evaluated at y, given the group.
}
}
\description{
Return the posterior predictive cdf
}
