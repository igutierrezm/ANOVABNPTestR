#' #' Return the YYY statistic associated with each factor
#' #'
#' #' @param fit An object of class anova_bnp_model.
#' #' @return A tibble with the following variables:
#' #' \itemize{
#' #'   \item var1: the 1st factor id.
#' #'   \item var2: the 2nd factor id.
#' #'   \item prob: the YYY summary statistic.
#' #' }
#' #' @export
#' hypothesis_post_interaction <- function(fit) {
#'   fit$hypothesis_post_interaction
#' }
