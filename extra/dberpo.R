# Probability mass function Bernoulli Poisson distribution
dberpo <- function(x, phi, lambda) {
  ngrid <- length(x)
  pmf <- rep(0, ngrid)
  for (i in 1:ngrid) {
    if (x[i] == 0) {
      pmf[i] = dpois(x = x[i], lambda = lambda)
    } else {
      pmf[i] = (
        (0 + phi) * dpois(x = x[i] - 1, lambda = lambda) +
        (1 - phi) * dpois(x = x[i] - 0, lambda = lambda)
      )
    }
  }
  return(pmf)
}
