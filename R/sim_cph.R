#' Simulate time-to-event Cox Proportional Hazards exponential model data
#'
#' Simulates survival data from a Cox Proportional Hazards model with the exponential distribution (Bender 2005).
#'
#' @param N desired sample size of simulated data
#' @param formula formula of covariates provided as vectors
#' @param X model matrix of covariates
#' @param beta vector of coefficients
#' @param tfun a time function from Bender 2005 with distributional parameters as input. Current options: `texp(lambda)`, `tweibull(lambda, nu)`, `tgompertz(lambda, alpha)`
#'
#' @return data.frame
#' @export
#'
#' @examples
#' x1 <- rnorm(10)
#' x2 <- rnorm(10)
#' sim_cph(N = 10, formula = ~ x1 + x2, beta = c(1, 0.5),  tfun = texp(lambda = 0.5))
sim_cph <- function(N, formula, X = NULL, beta, tfun = texp(lambda = 0.5)){
  #create model matrix if X is not supplied
  if(is.null(X)){
    X <- stats::model.matrix(formula)[,-1]
  }
  #check that the length of beta vector matches the number of covariates

  if(length(beta) != ncol(X)){
    stop("Length of beta does not match the number of columns of X")
  }

  #linear predictors
  Xbeta <- X %*% beta
  #sample N from a uniform(0, 1) distribution
  U <- stats::runif(N)
  #calculate simulated times
  t <- tfun(U, Xbeta)
  #output as data.frame
  data.frame(t = t, X)
}

