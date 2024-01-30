library(ANOVABNPTestR)
library(dplyr)
library(ggplot2)
library(tidyr)

# Probability mass function Bernoulli Poisson distribution
dberpo <- function(x, phi, lambda) {
  phi * dpois(x - 1, lambda) + (1 - phi) * dpois(x, lambda)
}

# Generates random draws from a Bernoulli Poisson distribution
rberpo <- function(n, phi, lambda) {
  rpois(n, lambda) + rbinom(n, size = 1, prob = phi)
}

n <- 10000
phi <- 0.8
lambda <- 0.5
yvec <- rberpo(n, phi, lambda)
Xmat <- matrix(1L, n, 1)
hist(yvec)
fit <-
  anova_bnp_berpoi(
    yvec,
    Xmat,
    iter = 2000L,
    warmup = 1000L,
    rho = 1.0,
    a = 0.1,
    b = 0.1,
    a1 = mean(yvec),
    b1 = 1.0,
    alpha0 = 1.0,
    beta0 = 1.0,
  )

fit$f_post |>
  dplyr::rename(fh = f) |>
  dplyr::mutate(f0 = dberpo(y, phi, lambda)) |>
  tidyr::pivot_longer(cols = fh:f0) |>
  ggplot2::ggplot(
    ggplot2::aes(x = y, color = name, y = value)
  ) +
  ggplot2::geom_line()



# N <- 1000
# x <- as.integer(1 + (runif(2 * N) < 0.5))
# Xmat <- matrix(x, nrow = N, ncol = 2)
# yvec <- rpois(N, 1) + (Xmat[, 1] == 2) * (Xmat[, 2] == 2)
# fit <- anova_bnp_berpoi(yvec, Xmat)
# hypothesis_post_simple(fit)
# hypothesis_post_interaction(fit)
