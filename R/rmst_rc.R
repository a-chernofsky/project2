#' Calculate restricted mean survival time for right censored data
#'
#' @param time vector of failure times
#' @param surv survival probabilities
#' @param tau time horizon
#'
#' @return integer
#' @export
#'
#' @examples
rmst_rc <- function(time, surv, tau){
  t <- sort(unique(time))
  lagt <- c(NA, t)[-(length(t) + 1)]
  lagt[1] <- 0
  tau <- 200

  lags <- c(NA, surv)[-(length(surv) + 1)]
  lags[1] <- 1
  nstar <- sum(t <= tau)
  sum((lags * (t - lagt))[1:nstar]) + surv[nstar] * (tau - t[nstar])
}

