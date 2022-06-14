#' Fit a Bayesian nonparametric factorial ANOVA model with Bernoulli kernel.
#'
#' @param y An boolean response vector.
#' @param X A design matrix (full of integer covariates).
#' @param iter the total number of mcmc iterations (default 4000).
#' @param warmup the number of warmup mcmc iterations (default 2000).
#' @param seed the seed for random number generation (default 1L).
#' @param rho the hyperparameter \eqn{\rho} (default 1.0).
#' @param a the hyperparameter \eqn{a} (default 1.0).
#' @param b the hyperparameter \eqn{b} (default 1.0).
#' @param a2 the hyperparameter \eqn{a_2} (default 2.0).
#' @param b2 the hyperparameter \eqn{b_2} (default 4.0).
#' @return An object of class 'anova_bnp_model'.
#' @importFrom dplyr as_tibble
#' @importFrom JuliaConnectoR juliaImport
#' @export
anova_bnp_bernoulli <- function(
  y, X, iter = 4000L, warmup = 2000L, seed = 1L, rho = 1.0,
  a = 1.0, b = 1.0, a2 = 2.0, b2 = 4.0, 
  lb = min(y), ub = max(y)
) {
  ANOVADDPTest <- juliaImport("ANOVADDPTest")
  fit <- ANOVADDPTest$anova_bnp_bernoulli(
    y, X, iter = iter, warmup = warmup, seed = seed, rho = rho,
    a = a, b = b, a2 = a2, b2 = b2, 
    lb = lb, ub = ub
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
