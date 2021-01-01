#' Generate a function that simulates time-to-event outcome from a Exponential Cox PH model
#'
#' @param lambda scale parameter (parameterization is E(X) = 1/lambda$)
#'
#' @return function that takes U and Xbeta as arguments
#' @export
#'
#' @examples
#' texp(0.5)
texp <- function(lambda){
  if(lambda <= 0) stop("scale parameter lambda must be strictly greater than 0")
  function(U, Xbeta) {
    - (log(U)) / (lambda * exp(Xbeta))
  }
}
