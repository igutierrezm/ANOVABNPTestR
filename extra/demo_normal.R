# Simulate a sample
{
  N <- 1000
  d <- sample(c(-1, +1), 1 * N, replace = TRUE, prob = c(0.3, 0.7))
  x <- sample(c(1L, 2L), 2 * N, replace = TRUE)
  Xmat <- matrix(x, nrow = N, ncol = 2)
  gvec1 <- Xmat[, 1]
  gvec2 <- Xmat[, 2]
  yvec <- 1.2 * d * (gvec1 == 1) * (gvec2 == 2) + rnorm(N) / 2
}

# Fit our ANOVA BNP model
fit <- anova_bnp_normal(yvec, Xmat)

# Plot the shift function for the second cell
shift_plot(fit, group = 2) # this should look like a tan().
shift_plot(fit, group = 3) # this should be a straight line.
