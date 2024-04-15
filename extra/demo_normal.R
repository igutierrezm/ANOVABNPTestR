# Simulate a sample
{
  set.seed(1)
  N <- 1000
  d <- 2 * (rnorm(N) <= 0.7) - 1
  x <- sample(0L:2L, N, replace = TRUE)
  Xmat <- matrix(x, nrow = N, ncol = 1)
  yvec <-  1.2 * (x == 2L) * d + rnorm(N) / 2
}

# Fit our ANOVA BNP model
fit <- anova_bnp_normal(yvec, Xmat, n = 100L)

# Plot the shift function for the second cell
shift_plot(fit, group1 = 1, group2 = 2)
shift_plot(fit, group1 = 1, group2 = 3)

