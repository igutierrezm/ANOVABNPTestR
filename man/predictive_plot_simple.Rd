% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/predictive_plot_simple.R
\name{predictive_plot_simple}
\alias{predictive_plot_simple}
\title{Plot the posterior predictive pdf (simple effects)}
\usage{
predictive_plot_simple(fit, d1)
}
\arguments{
\item{fit}{An object of class anova_bnp_model.}

\item{d1}{The factor id.}
}
\value{
A ggplot2 plot.
}
\description{
Plot the posterior predictive pdf for each value of 1 factor,
fixing the others at the reference level.
}
