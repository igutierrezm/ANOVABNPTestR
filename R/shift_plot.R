#' Plot a shift function
#'
#' Plot the shift function for one particular group.
#' @param fit An object of class anova_bnp_model.
#' @param group The group id.
#' @return A ggplot2 plot.
#' @importFrom dplyr filter
#' @importFrom ggplot2 aes geom_line ggplot
#' @importFrom rlang := .data
#' @export
shift_plot <- function(fit, group) {
  out <-
    fit |>
    shift_post() |>
    dplyr::filter(.data$group == group) |>
    ggplot2::ggplot(ggplot2::aes(x = y, y = shift)) +
    ggplot2::geom_line()
  return(out)
}
