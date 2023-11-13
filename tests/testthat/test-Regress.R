test_that("Regress works", {
  data(mtcars)
  result = JusticeRegress(Y = mtcars$mpg, X = cbind(mtcars$cyl))
  # Check coefficients of the model
  expect_equal(result$Estimates[1,1], 37.88458, tolerance = 0.0000001)
  expect_equal(result$Estimates[2,1], -2.87579, tolerance = 0.0000001)
})

test_that("reject if length(Y) is not equal to  rows of X or X is not a column vetor", {
  set.seed(12)
  n <- 100
  x <- rnorm(n)
  y <- rnorm(n-1)
   # Check coefficients of the model
  expect_error(JusticeRegress(Y = y, X = cbind(x)),"X needs to be a column vector or the number of rows in X and length of Y should be equal")
})



