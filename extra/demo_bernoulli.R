# Simulate a sample
{
  set.seed(1)
  N <- 1000
  d <- 2 * (rnorm(N) <= 0.7) - 1
  x <- sample(0L:2L, N, replace = TRUE)
  Xmat <- matrix(x, nrow = N, ncol = 1)
  yvec <- runif(N) <= (0.5 + 0.3 * (x == 2L) * d)
}

# Fit our ANOVA BNP model
fit <- anova_bnp_bernoulli(yvec, Xmat, iter = 10000L, warmup = 6000L)

# Show MCMC results for gamma
gamma_chain(fit)

# Show the factors combination associated to each group
group_codes(fit)

# Show the posterior distribution of gamma
gamma_post(fit)

# Perform our Dunnet-like test
joint_significance_probability(fit)
