# ANOVABNPTestR

[![docs](https://img.shields.io/badge/docs-stable-blue.svg)](https://igutierrezm.github.io/ANOVABNPTestR/index.html)

An R package that implements the (BNP) Factorial ANOVA model described in 
Gutiérrez et al. (2021). See the 
[documentation](https://igutierrezm.github.io/ANOVABNPTestR/index.html) 
for details and the 
[getting started](https://igutierrezm.github.io/ANOVABNPTestR/articles/getting_started.html) 
vignette for a working example.

## Installation

You can install ANOVABNPTestR from source as follows:

```r
remotes::install_github("igutierrezm/ANOVABNPTestR")
```

This will install the R package ANOVABNPTestR, but not the Julia packages on
which it depends. In order to install these Julia packages, run

```r
ANOVABNPTestR::setup()
```

You only need to do this once.

## Dependencies

ANOVABNPTestR requires Julia v1.6.1+. You can download it 
[here](https://julialang.org/downloads/), 
and then install it following these 
[instructions](https://julialang.org/downloads/platform/).
