#' Generate a function that simulates time-to-event outcome from a Weibull Cox PH model
#'
#' @param lambda scale parameter
#' @param nu shape parameter
#'
#' @return function
#' @export
#'
#' @examples
#' tweibull(0.5, 1)
tweibull <- function(lambda, nu){
  if(lambda <= 0) stop("scale parameter lambda must be strictly greater than 0")
  if(nu <= 0) stop("shape parameter nu must be strictly greater than 0")
  function(U, Xbeta) {
    (-(log(U)) / (lambda * exp(Xbeta)))^(1/nu)
  }
}
