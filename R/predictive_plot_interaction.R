#' Plot the posterior predictive pdf (interactions)
#'
#' Plot the posterior predictive pdf for each combination of 2 factors,
#' fixing the others at the reference level.
#' @param fit An object of class anova_bnp_model.
#' @param d1 The 1st factor id.
#' @param d2 The 2nd factor id.
#' @return A ggplot2 plot.
#' @importFrom dplyr mutate filter left_join c_across
#' @importFrom ggplot2 ggplot aes_string geom_line
#' @importFrom rlang := .data
predictive_plot_interaction <- function(fit, d1, d2) {
  var1 <- paste0("x", d1)
  var2 <- paste0("x", d2)
  group_codes(fit) |>
    mutate(x0 = 1) |>
    mutate(
      touse = pmax(c_across(-c("group", var1, var2))),
      touse = .data$touse == 1,
      touse = .data$touse & (.data[[var1]] == 1 | .data[[var2]] != 1),
      touse = .data$touse & (.data[[var1]] != 1 | .data[[var2]] == 1)
    ) |>
    filter(.data$touse) |>
    left_join(f_post(fit)) |>
    mutate(
      {{ var1 }} := factor(.data[[var1]]),
      {{ var2 }} := factor(.data[[var2]])
    ) |>
    ggplot(aes_string(x = "y",y = "f", color = paste0(var1, ":", var2))) +
    geom_line()
}