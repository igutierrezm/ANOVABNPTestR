#' Plot the posterior predictive pdf (simple effects)
#'
#' Plot the posterior predictive pdf for each value of 1 factor,
#' fixing the others at the reference level.
#' @param fit An object of class anova_bnp_model.
#' @param d1 The factor id.
#' @return A ggplot2 plot.
#' @importFrom dplyr mutate filter left_join c_across
#' @importFrom ggplot2 ggplot aes_string geom_line
#' @importFrom rlang := .data
predictive_plot_simple <- function(fit, d1) {
  var1 <- paste0("x", d1)
  group_codes(fit) |>
    mutate(touse = pmax(c_across(-c("group", var1)))) |>
    filter(.data$touse == 1) |>
    left_join(f_post(fit)) |>
    mutate({{ var1 }} := factor(.data[[var1]])) |>
    ggplot(aes_string(x = "y", y = "f", color = var1)) +
    geom_line()
}
