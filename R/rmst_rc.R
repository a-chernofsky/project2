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
#' #' library(survival)
#' data(kidney)
#' s <- survfit(Surv(time, status) ~ 1, data = kidney)$surv
#' rmst_rc(kidney$time, s, tau = 50)
rmst_rc <- function(time, surv, tau){
  t <- sort(unique(time))
  lagt <- c(NA, t)[-(length(t) + 1)]
  lagt[1] <- 0

  lags <- c(NA, surv)[-(length(surv) + 1)]
  lags[1] <- 1
  nstar <- sum(t <= tau)
  sum((lags * (t - lagt))[1:nstar]) + surv[nstar] * (tau - t[nstar])
}

