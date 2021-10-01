#' Return the factor levels associated with each group
#'
#' @param fit An object of class anova_bnp_model.
#' @return A tibble with the factor levels associated with each group
#' and the following variables:
#' \itemize{
#'   \item group: the group id.
#'   \item x\eqn{i}: the level of the \eqn{i}th factor for that  group,
#'   for each \eqn{i = 1, 2, \ldots}
#' }
#' @export
group_codes <- function(fit) {
  fit$group_codes
}
