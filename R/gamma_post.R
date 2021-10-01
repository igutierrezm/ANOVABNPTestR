#' Return the posterior probability of each hypothesis vector
#'
#' @param fit An object of class anova_bnp_model.
#' @return A tibble with the posterior probability of each hypothesis
#' (one per row), and the following variables:
#' \itemize{
#'   \item prob: the posterior probability.
#'   \item group\eqn{i}: TRUE if, under that hypothesis, the group 1 shares the
#'   distribution of the reference group, for each \eqn{i = 2, 3, \ldots}
#' }
#' For more information about the meaning of each group, use \code{group_codes}.
#' @export
gamma_post <- function(fit) {
  fit$gamma_post
}
