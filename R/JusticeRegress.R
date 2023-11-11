#'JusticeRegress: Fits a Linear Regression model
#'
#'This comprehensive function is used to fit both Simple and Multiple Linear Regression models. The package is designed to be user-friendly.It provides
#'estimates of the Regression coefficients, standard error, t values, p values, confidence intervals
#'for the estimates and the fitted values from the model.
#'
#'@param Y a numeric vector of the responses
#'@param X a numeric design matrix for the model.It is a column vector for Simple Linear Regression and matrix for Multiple Linear Regression. See details for more information.
#'@param alpha the significance level for your hypotheses tests
#'
#'@details
#'The function uses the Ordinary Least Squares (OLS) method to estimate regression coefficients. It internally computes standard errors, t values, and p values for each coefficient. Confidence intervals are calculated based on the specified alpha level. Fitted values are obtained directly from the OLS model.When fitting an SLR model, X should be a column vector otherwise X is a matrix where each column represents a specific variable in the model.
#'
#'@return A list including elements
#'\item{Estimates}{a dataframe for the estimated coefficients, standard errors, t values, and their p values}
#'\item{Confidence_Intervals}{confidence intervals for the regression coefficients}
#'\item{Fitted_values}{a vector of the fitted values from the model}
#'
#'@author Justice Akuoko-Frimpong
#'
#'@references {Chambers, J. M. (1992) Linear models. Chapter 4 of Statistical Models in S eds J. M. Chambers and T. J. Hastie, Wadsworth & Brooks/Cole.}
#'
#'@examples
#'#Example 1 for Simple Linear Regression
#' #mtcars dataset in R
#'data(mtcars)
#'X=cbind(mtcars$hp) #For Simple Linear Regression X must be a column vector
#'Y=mtcars$mpg
#'JusticeRegress(Y, X, alpha = 0.05)
#'
#'#Example 2 for Multiple Linear Regression
#'Y=c(27,29,23,20,21)
#'X=cbind(c(4,7,6,2,3),c(0,1,1,0,0),c(1,1,0,0,1))
#'JusticeRegress(Y,X) #without specifying alpha.Still uses 0.05
#'
#' @importFrom stats pt qt
#'@export
#'
JusticeRegress = function(Y, X, alpha=0.05){ #initialize alpha

  # X needs to be a matrix or a column vector
  # Makes sure that the length of Y and the number of rows in X are the same

  if(length(Y) != nrow(X)){
    stop("X needs to be a column vector or the number of rows in X and length of Y should be equal")
  }

  # Add 1s to the design matrix X for the intercept
  X = cbind(1,X)

  # The matrices and vectors needed for beta computation
  X_t_X = t(X) %*% X
  X_t_Y = t(X) %*% Y

  # Estimates of the beta coefficients
  beta_coef = solve(X_t_X) %*% X_t_Y

  # Predicted values
  Y_hat = X %*% beta_coef

  # Degrees of freedom (n-p)
  df = nrow(X) - ncol(X)

  # Calculate the residuals
  residuals = Y - Y_hat

  # Sum of squares due to errors
  SSE = sum(residuals^2)

  # Standard errors, t statistics, and their corresponding p-values
  std_error = sqrt(diag((SSE/df )* solve(X_t_X)))
  t_values = beta_coef/std_error
  p_values = 2 * (1 - pt(abs(t_values), df))

  # Confidence intervals calculation
  conf_int = matrix(NA, nrow = length(beta_coef), ncol = 2)
  critical_value = qt(1-alpha/2,df)
  conf_int[,1] = (beta_coef) - (critical_value * std_error)
  conf_int[,2] = (beta_coef) + (critical_value * std_error)


  # Put first results in a data.frame form
  solution1 = data.frame(
    coefficients = beta_coef,
    standard_errors = std_error,
    t_values = t_values,
    p_values = p_values
  )

  # Create another data.frame for confidence intervals
  solution2 = data.frame(
    lower_limit = conf_int[,1],
    upper_limit = conf_int[,2]
  )

  # Create another data.frame for the fitted values
  solution3 = data.frame(
    Y_hat =Y_hat
  )

  # Return a list of all the solutions
  return(list(Estimates=solution1,Confidence_Intervals=solution2,Fitted_values=solution3))
}
