#' Generate a function that simulates time-to-event outcome from a Gompertz Cox PH model
#'
#' @param lambda scale parameter
#' @param alpha shape parameter
#'
#' @return function
#' @export
#'
#' @examples
#' tgompertz(0.5, 1)
tgompertz <- function(lambda, alpha){
  if(lambda <= 0) stop("scale parameter lambda must be strictly greater than 0")
  function(U, Xbeta) {
    (1/alpha) * log(1 - (alpha * log(U))/(lambda * exp(Xbeta)))
  }
}
