# Regress R Package

[![R-CMD-check](https://github.com/JusticeAkuoko-Frimpong/Regress/workflows/R-CMD-check/badge.svg)](https://github.com/JusticeAkuoko-Frimpong/Regress/actions)
[![codecov](https://codecov.io/gh/JusticeAkuoko-Frimpong/Regress/branch/master/graph/badge.svg?token=abcdefg123456)](https://codecov.io/gh/JusticeAkuoko-Frimpong/Regress)



The goal of the Regress package is to provide function to fit Simple and Multiple Linear Regression models.

## Description
The Regress package provides a comprehensive function to fit both Simple and Multiple Linear Regression models. The package is designed to be user-friendly.It provides estimates of the Regression coefficients, standard error, t values, p values, confidence intervals for the estimates and the fitted values from the model.

## Getting Started

### Installing
You can install the `Regress` package using the `devtools` package:
```r
# Install devtools if not already installed
if (!requireNamespace("devtools", quietly = TRUE)) {
  install.packages("devtools")
}
```
Install the development version from [GitHub](https://github.com/) with:
```r
# Install Regress from GitHub
devtools::install_github("JusticeAkuoko-Frimpong/Regress@master")
```
### Example
Using the mtcars dataset. Suppose we are interested in fitting a simple linear regression model of hp on mpg
```r
library(Regress)
data(mtcars)
X=cbind(mtcars$hp) #For Simple Linear Regression X must be a column vector
Y=mtcars$mpg
JusticeRegress(Y, X, alpha = 0.05)
```

```r
#another example
Y=c(27,29,23,20,21)
X=cbind(c(4,7,6,2,3),c(0,1,1,0,0),c(1,1,0,0,1))
JusticeRegress(Y,X) 
```
These will return a list of the estimates, standard errors, t values, p values, confidence interval for the estimates and fitted values from the model.
## Help
For SLR models make sure X is a column vector

## Author
Justice Akuoko-Frimpong <jakuokof@umich.edu>
