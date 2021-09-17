#' Return the posterior predictive pdf of a convenient grid of points
#'
#' @param fit An object of class anova_bnp_model.
#' @return A tibble with the following variables:
#' \itemize{
#'   \item group the group id.
#'   \item y the value of the response variable.
#'   \item the posterior predictive pdf evaluated at y, given the group.
#' }
f_post <- function(fit) {
  fit$f_post
}
