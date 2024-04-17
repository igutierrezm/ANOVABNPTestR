# ANOVABNPTestR

[![docs](https://img.shields.io/badge/docs-stable-blue.svg)](https://igutierrezm.github.io/ANOVABNPTestR/index.html)

An R package that implements the (BNP) Factorial ANOVA model described in 
Gutiérrez et al. (2024). See the 
[documentation](https://igutierrezm.github.io/ANOVABNPTestR/index.html) 
for details and the 
[getting started](https://igutierrezm.github.io/ANOVABNPTestR/articles/getting_started.html) 
vignette for a working example.

## Installation

You can install `ANOVABNPTestR` from source as follows:

```r
remotes::install_github("igutierrezm/ANOVABNPTestR")
```

You can install its Julia dependencies as follows:

```r
ANOVABNPTestR::setup()
```

You only need to do this once.

## Dependencies

`ANOVABNPTestR` requires Julia v1.6.1+. You can download it from
[here](https://julialang.org/downloads/). See the following
[link](https://julialang.org/downloads/platform/) for instructions.
