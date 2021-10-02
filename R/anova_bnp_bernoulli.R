#' Fit a Bayesian nonparametric factorial ANOVA model with Bernoulli kernel.
#'
#' @param y An boolean response vector.
#' @param X A design matrix (full of integer covariates).
#' @param iter the total number of mcmc iterations (default 4000).
#' @param warmup the number of warmup mcmc iterations (default 2000).
#' @param seed the seed for random number generation (default 1L).
#' @param zeta0 the hyperparameter \eqn{\zeta_0} (default 1.0).
#' @param a0 the hyperparameter \eqn{a_0} (default 1.0).
#' @param b0 the hyperparameter \eqn{b_0} (default 1.0).
#' @param a1 the hyperparameter \eqn{a_1} (default 2.0).
#' @param b1 the hyperparameter \eqn{b_1} (default 4.0).
#' @return An object of class 'anova_bnp_model'.
#' @importFrom dplyr as_tibble
#' @importFrom JuliaConnectoR juliaImport
#' @export
anova_bnp_bernoulli <- function(
  y, X, iter = 4000L, warmup = 2000L, seed = 1L, zeta0 = 1.0,
  a0 = 1.0, b0 = 1.0, a1 = 2.0, b1 = 4.0
) {
  ANOVADDPTest <- juliaImport("ANOVADDPTest")
  fit <- ANOVADDPTest$anova_bnp_bernoulli(
    y, X, iter = iter, warmup = warmup, seed = seed, zeta0 = zeta0,
    a0 = a0, b0 = b0, a1 = a1, b1 = b1
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
