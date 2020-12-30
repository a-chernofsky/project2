#' Simulate time-to-event Cox Proportional Hazards exponential model data
#'
#' Simulates survival data from a Cox Proportional Hazards model with the exponential distribution (Bender 2005).
#'
#' @param N desired sample size of simulated data
#' @param formula formula of covariates
#' @param beta vector of coefficients
#' @param lambda scale parameter from the exponential distribution
#'
#' @return data.frame
#' @export
#'
#' @examples
#' x1 <- rnorm(10)
#' x2 <- rnorm(10)
#' sim_cph(10, ~ x1 + x2, c(1, 0.5, 0.5), 0.50)
sim_cph <- function(N, formula, beta, lambda){
  X <- stats::model.matrix(formula)
  Xbeta <- X %*% beta
  U <- stats::runif(N)
  l <- lambda
  t <- - (log(U)) / (l * exp(Xbeta))
  data.frame(t = t, X[,-1])
}

