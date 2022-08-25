library(ANOVABNPTestR)

N <- 1000
x <- as.integer(1 + (runif(2 * N) < 0.5))
Xmat <- matrix(x, nrow = N, ncol = 2)
yvec <- rpois(N, 1) + (Xmat[, 1] == 2) * (Xmat[, 2] == 2)
fit <- anova_bnp_berpoi(yvec, Xmat)
hypothesis_post_simple(fit)
hypothesis_post_interaction(fit)
