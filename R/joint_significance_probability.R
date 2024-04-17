#' Compute the posterior probability of having at least one relevant factor
#'
#' @param fit An object of class anova_bnp_model.
#' @return The corresponding probability.
#' @export
joint_significance_probability <- function(fit) {
  prob <-
    fit$gamma_post |>
    dplyr::arrange(dplyr::pick(dplyr::starts_with("group"))) |>
    dplyr::slice_head(n = 1) |>
    tidyr::pivot_longer(-prob) |>
    dplyr::summarise(prob = mean(prob) * all(!value))
  out <- 1 - prob
  return(out)
}
