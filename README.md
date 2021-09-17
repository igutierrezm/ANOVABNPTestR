# ANOVABNPTestR

Implements the Bayesian Nonparametric Factorial ANOVA model described in XXX.

## Installation

```r
devtools::install_github("igutierrezm/ANOVABNPTestR")
```

## Dependencies

`ANOVABNPTestR` depends on Julia (v1.6.1+). 
Users must install Julia by themmselves.

## Main functions

```r
setup() # check the julia dependencies
fit <- anova_bnp_poisson(y, X, ...)      # fit the model
f_post(fit)                              # return p(y0 | x, y)
gamma_post(fit)                          # return p(gamma | y)
group_codes(fit)                         # return the meaning of each group
predictive_plot_simple(fit, d1)          # plot p(y0, x, y) (simple effects only)
predictive_plot_interaction(fit, d1, d2) # plot p(y0, x, y) (interactions only)
hypothesis_post_simple(fit)              # return the XXX summary statistic
hypothesis_post_interaction(fit)         # return the YYY summary statistic
```
