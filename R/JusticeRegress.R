JusticeRegress = function(Y, X, alpha=0.05){ #initialize alpha

  # X needs to be a matrix or a column vector
  # Make sure that the length of Y and the number of rows in X are the same

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

