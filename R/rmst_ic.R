#' Calculate the restricted mean survival time for interval censored data
#'
#' @param left numeric vector of left endpoints of censoring interval
#' @param right numeric vector of right endpoints of censoring interval
#' @param tau time horizon
#'
#' @return numeric
#' @export
#'
#' @examples
#' library(interval)
#' data(bcos)
#' rmst_ic(bcos$left, bcos$right, tau = 30)
rmst_ic <- function(left, right, tau, subset = NULL){
  if(length(right) != length(left))stop("the left and right vectors must be of the same length")

  #if subset option is provided, subset the data
  if(!is.null(subset)){
    left <- left[subset]
    right <- right[subset]
  }

  #fit survival curve
  icfit <- interval::icfit(left, right)

  #outcome matrix
  out <- cbind(s = c(1, c(1 - cumsum(icfit$pf))),
               l = c(0,
                     icfit$intmap[2, ]), r = c(icfit$intmap[1, ], Inf),
               out = 1)
  #midpoint matrix
  mid <- cbind(s = (out[1:(nrow(out)-1), "s"] + out[2:nrow(out), "s"])/2,
               l = icfit$intmap[1, ],
               r = icfit$intmap[2, ],
               out = 0)
  #combine the matrices
  all <- rbind(out, mid)
  all <- all[order(all[,"l"], all[,"r"]), ]
  #calculate interval lengths
  diff <- all[,"r"] - all[,"l"]
  #calculate areas for specific intervals
  prod <- all[,"s"] * diff
  #number of intervals less than tau
  nstar <- which(all[,"l"] <= tau & all[, "r"] > tau)
  #survival probablity at tau
  stau <- interval::getsurv(tau, icfit)[[1]]$S

  #combine results
  p1 <- sum(prod[1:(nstar - 1)])
  p2 <- all[nstar, "out"] * stau * (tau - all[nstar, "l"]) +
    (1 - all[nstar, "out"]) * (all[nstar, "s"] + stau)/2 * (tau - all[nstar, "l"])
  p1 + p2
}


