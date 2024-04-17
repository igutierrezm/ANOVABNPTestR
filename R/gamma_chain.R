#' Return the markov chain associated to the hypothesis vector
#'
#' @param fit An object of class anova_bnp_model.
#' @return A tibble with the markov chian associated to the hypothesis
#' vector, and the following variables:
#' \itemize{
#'   \item iter: MCMC iteration.
#'   \item variable: The name of the variable.
#'   \item value: The value of the variable at iteration each iteration.
#' }
#' For more information about the meaning of each group, use \code{group_codes}.
#' @export
gamma_chain <- function(fit) {
  out <-
    fit$gamma_chain |>
    dplyr::rename(group = variable) |>
    dplyr::mutate(group = gsub("gamma", "", group) |> as.integer())
  return(out)
}
