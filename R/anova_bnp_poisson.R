#' #' Fit a Bayesian nonparametric factorial ANOVA model with Poisson kernel
#' #'
#' #' @param y An integer vector with the responses.
#' #' @param X A integer matrix with the covariates.
#' #' @param iter the total number of mcmc iterations.
#' #' @param warmup the number of warmup mcmc iterations.
#' #' @param seed the seed for random number generation.
#' #' @param rho the hyperparameter \eqn{\rho}.
#' #' @param a the hyperparameter \eqn{a}.
#' #' @param b the hyperparameter \eqn{b}.
#' #' @param a1 the hyperparameter \eqn{a_1}.
#' #' @param b1 the hyperparameter \eqn{b_1}.
#' #' @return An object of class `anova_bnp_model`.
#' #' @importFrom dplyr as_tibble
#' #' @importFrom JuliaConnectoR juliaImport
#' #' @export
#' anova_bnp_poisson <- function(
#'   y, X, iter = 4000L, warmup = 2000L, seed = 1L, rho = 1.0,
#'   a = 1.0, b = 1.0, a1 = 2.0, b1 = 4.0,
#'   lb = min(y), ub = max(y)
#' ) {
#'   ANOVADDPTest <- juliaImport("ANOVADDPTest")
#'   fit <- ANOVADDPTest$anova_bnp_poisson(
#'     y, X, iter = iter, warmup = warmup, seed = seed, rho = rho,
#'     a = a, b = b, a1 = a1, b1 = b1,
#'     lb = lb, ub = ub
#'   )
#'   out <-
#'     list(
#'       f_post = fit$fpost,
#'       gamma_post = fit$group_probs,
#'       group_codes = fit$group_codes
#'     ) |>
#'     lapply(as.data.frame) |>
#'     lapply(dplyr::as_tibble)
#'   class(out) <- "anova_bnp_model"
#'   out
#' }
