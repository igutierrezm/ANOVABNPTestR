# ANOVABNPTestR

[![docs](https://img.shields.io/badge/docs-stable-blue.svg)](https://igutierrezm.github.io/ANOVABNPTestR/)

Implements the Bayesian Nonparametric Factorial ANOVA model described in 
Gutiérrez et al. (2021). See the 
[documentation](https://igutierrezm.github.io/ANOVABNPTestR/) 
for details.

## Installation

```r
remotes::install_github("igutierrezm/ANOVABNPTestR")
```

## Dependencies

`ANOVABNPTestR` requires Julia (v1.6.1+). If you still do not have Julia, you 
can download it from [the oficial website](https://julialang.org/downloads/), 
and then install it following these 
[platform specific instruction](https://julialang.org/downloads/platform/).

## Main functions

```r
setup()                                  # check the julia dependencies
fit <- anova_bnp_normal(y, X, ...)       # fit the model (normal kernel)
fit <- anova_bnp_poisson(y, X, ...)      # fit the model (poisson kernel)
fit <- anova_bnp_bernoulli(y, X, ...)    # fit the model (bernoulli kernel)
f_post(fit)                              # return p(y0 | x, y)
gamma_post(fit)                          # return p(gamma | y)
group_codes(fit)                         # return the meaning of each group
predictive_plot_simple(fit, d1)          # plot p(y0, x, y) (simple effects only)
predictive_plot_interaction(fit, d1, d2) # plot p(y0, x, y) (interactions only)
hypothesis_post_simple(fit)              # return the XXX statistic
hypothesis_post_interaction(fit)         # return the YYY statistic
```
