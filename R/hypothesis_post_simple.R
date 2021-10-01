#' Return the XXX statistic associated with each factor
#'
#' @param fit An object of class anova_bnp_model.
#' @return A tibble with the following variables:
#' \itemize{
#'   \item var1: factor id.
#'   \item prob: the XXX summary statistic.
#' }
#' @export
hypothesis_post_simple <- function(fit) {
  fit$hypothesis_post_simple
}
