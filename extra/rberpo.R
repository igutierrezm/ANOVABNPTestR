# Generates random draws from a Bernoulli Poisson distribution
rberpo = function(n, phi, lambda) {
  y <- rep(0, n)
  index <- 1:2
  weights <- c(phi, 1 - phi)
  for (i in 1:n) {
    j <- sample(x = index, size = 1, prob = weights)
    if (j == 1) {
      y[i] <- rpois(1, lambda = lambda) + 1
    } else {
      y[i] <- rpois(n = 1, lambda = lambda)
    }
  }
  return(y)
}

