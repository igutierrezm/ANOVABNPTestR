N <- 1000
x <- as.integer(1 + (runif(2 * N) < 0.5))
Xmat <- matrix(x, nrow = N, ncol = 2)
yvec <- rnorm(N)
fit <- anova_bnp_normal(yvec, Xmat)

tbl_shift <- shift_post(fit)
hypothesis_post_simple(fit)
hypothesis_post_interaction(fit)

shift_plot(fit, group = 2)
