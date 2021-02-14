#' Calculate restricted mean survival time for right censored data
#'
#' @param time vector of failure times
#' @param event vector of event status.
#' @param tau time horizon
#' @param subset vector of indices or logical vector indicating desired subset
#'
#' @return integer
#' @export
#'
#' @examples
#' library(survival)
#' data(kidney)
#' s <- survfit(Surv(time, status) ~ 1, data = kidney)$surv
#' rmst_rc(time = kidney$time, event = kidney$status, tau = 50)
rmst_rc <- function(time, event, tau, subset = NULL){
  #check that at least event vector or survival probabities are provided
  if(is.null(event) | is.null(time)) stop("You must supply both event and status vectors.")
  #check that time and event vectors are the sample length
  if(!is.null(event) & length(time) != length(event)) stop("The time and event vectors must be of the same length")
  #if subset option is used subset the vectors
  if(!is.null(subset)){
    time <- time[subset]
    event <- event[subset]
  }
  #calculate survival probabilities
  #calculate survival probabilities
  sfun <- survival::survfit(survival::Surv(time, event) ~ 1)
  surv <- sfun$surv
  t <- sort(sfun$time)

  #create lagged vector of time
  lagt <- c(NA, t)[-(length(t) + 1)]
  lagt[1] <- 0

  #create lagged vector of survival probabilities
  lags <- c(NA, surv)[-(length(surv) + 1)]
  lags[1] <- 1
  #number of observations less than tau
  nstar <- sum(t <= tau)
  #rmst estimate
  sum((lags * (t - lagt))[1:nstar]) + surv[nstar] * (tau - t[nstar])
}

