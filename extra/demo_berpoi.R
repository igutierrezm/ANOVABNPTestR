library(ANOVABNPTestR)
library(dplyr)
library(tidyr)
ANOVABNPTestR::setup()

dberpoi <- function(x, lambda, alpha) {
  alpha * dpois(x - 1, lambda) + (1 - alpha) * dpois(x, lambda)
}

# Simulate a sample
N <- 2000
lambda <- 1
alpha <- 0.5
Xmat <- matrix(1L, nrow = N, ncol = 1)
yvec <- rpois(N, lambda) + rbinom(N, 1, alpha)

# Fit the model
fit <- anova_bnp_berpoi(yvec, Xmat)

# Extract the posterior predictive density
df <- f_post(fit)

# Add the true density
df <-
  df |>
  dplyr::mutate(ftrue = dberpoi(y, lambda, alpha)) |>
  dplyr::rename(fbnp = f) |>
  tidyr::pivot_longer(cols = c(ftrue, fbnp))

# Plot the true and fitted densities
df |>
  ggplot2::ggplot(ggplot2::aes(x = y, color = name, y = value)) +
  ggplot2::geom_line()
