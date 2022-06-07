#' Fit a Bayesian nonparametric factorial ANOVA model with Gaussian kernel.
#'
#' @param y A continuous response vector.
#' @param X A design matrix (full of integer covariates).
#' @param iter the total number of mcmc iterations (default 4000).
#' @param warmup the number of warmup mcmc iterations (default 2000).
#' @param seed the seed for random number generation (default 1L).
#' @param n the number of points y0 for computing p(y0 | y) (default 50L).
#' The final grid is conformed by n equispaced point from
#' \code{min(y) - sd(y) / 2} to \code{max(y) -  sd(y) / 2}
#' @param zeta0 the hyperparameter \eqn{\zeta_0} (default 1.0).
#' @param a0 the hyperparameter \eqn{a_0} (default 1.0).
#' @param b0 the hyperparameter \eqn{b_0} (default 1.0).
#' @param v0 the hyperparameter \eqn{v_0} (default 2.0).
#' @param r0 the hyperparameter \eqn{r_0} (default 1.0).
#' @param u0 the hyperparameter \eqn{u_0} (default 0.0).
#' @param s0 the hyperparameter \eqn{s_0} (default 1.0).
#' @return An object of class 'anova_bnp_model'.
#' @importFrom dplyr as_tibble
#' @importFrom JuliaConnectoR juliaImport
#' @export
anova_bnp_normal <- function(
  y, X, iter = 4000L, warmup = 2000L, seed = 1L, n = 50L, zeta0 = 1.0,
  a0 = 1.0, b0 = 1.0, v0 = 2.0, r0 = 1.0, u0 = 0.0, s0 = 1.0,
  lb = mean(y) - 0.5 * sd(y), ub = mean(y) + 0.5 * sd(y)
) {
  ANOVADDPTest <- juliaImport("ANOVADDPTest")
  fit <- ANOVADDPTest$anova_bnp_normal(
    y, X, iter = iter, warmup = warmup, seed = seed, n = n, zeta0 = zeta0,
    a0 = a0, b0 = b0, v0 = v0, r0 = r0, u0 = u0, s0 = s0, lb = lb, ub = ub
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
