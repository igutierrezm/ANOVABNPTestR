#' Fit a Bayesian nonparametric factorial ANOVA model with Gaussian kernel.
#'
#' @param y a continuous response vector.
#' @param X a design matrix (full of integer covariates).
#' @param iter the total number of mcmc iterations (default 4000).
#' @param warmup the number of warmup mcmc iterations (default 2000).
#' @param seed the seed for random number generation (default 1L).
#' @param n the number of points y0 for computing p(y0 | y) (default 50L).
#' The final grid is conformed by n equispaced points from `lb` to `ub`, see
#' the arguments `lb` and `ub`
#' @param rho the hyperparameter \eqn{\rho} (default 1.0).
#' @param a the hyperparameter \eqn{a} (default 1.0).
#' @param b the hyperparameter \eqn{b} (default 1.0).
#' @param mu0 the hyperparameter \eqn{\mu_0} (default 0.0).
#' @param lambda0 the hyperparameter \eqn{\lambda_0} (default 1.0).
#' @param a0 the hyperparameter \eqn{a_0} (default 2.0).
#' @param b0 the hyperparameter \eqn{b_0} (default 1.0).
#' @param lb the lower bound of the prediction grid, default: `mean(y) - 3.0 * sd(y)`
#' @param ub the upper bound of the prediction grid, default: `mean(y) + 3.0 * sd(y)`
#' @param standardize_y Select `TRUE` to internally standardize the data,
#' fit the model, and present the results in the original scale
#' @return An object of class 'anova_bnp_model'.
#' @importFrom dplyr as_tibble
#' @importFrom JuliaConnectoR juliaImport
#' @export
anova_bnp_normal <- function(
  y, X, iter = 4000L, warmup = 2000L, seed = 1L, n = 50L, rho = 1.0,
  a = 1.0, b = 1.0, a0 = 2.0, lambda0 = 1.0, mu0 = 0.0, b0 = 1.0,
  lb = mean(y) - 3.0 * sd(y), ub = mean(y) + 3.0 * sd(y),
  standardize_y = FALSE
) {
  ANOVADDPTest <- juliaImport("ANOVADDPTest")
  fit <- ANOVADDPTest$anova_bnp_normal(
    y, X, iter = iter, warmup = warmup, seed = seed, n = n, rho = rho,
    a = a, b = b, mu0 = mu0, lambda0 = lambda0, a0 = a0, b0 = b0,
    lb = lb, ub = ub, standardize_y = standardize_y
  )
  out <-
    list(
      f_post = fit$fpost,
      gamma_post = fit$group_probs,
      group_codes = fit$group_codes,
      hypothesis_post_simple = fit$effects1,
      hypothesis_post_interaction = fit$effects2
    ) |>
    lapply(as.data.frame) |>
    lapply(dplyr::as_tibble)
  class(out) <- "anova_bnp_model"
  out
}
