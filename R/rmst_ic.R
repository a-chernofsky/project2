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
rmst_ic <- function(left, right, tau){
  icfit <- interval::icfit(left, right)

  out <- data.frame(s = c(1, c(1-cumsum(icfit$pf))),
                    l = c(0,icfit$intmap[2,]),
                    r = c(icfit$intmap[1,], Inf),
                    out = T)

  mid <- data.frame(s = NA,
                    l = icfit$intmap[1,],
                    r = icfit$intmap[2,],
                    out = F)

  for(i in 1:(nrow(out) - 1)){
    mid$s[i] <- (out$s[i] + out$s[i + 1])/2
  }

  all <- rbind(out, mid, make.row.names = F)
  all <- all[order(all$l, all$r),]
  all$diff <- all$r - all$l
  all$prod <- all$s*all$diff

  nstar <- which(all$l <= tau & all$r > tau)
  stau <- getsurv(tau, icfit)[[1]]$S

  p1 <- sum(all$prod[1:(nstar - 1)])
  p2 <- all$out[nstar] * stau * (tau - all$l[nstar]) + (1- all$out[nstar]) * (all$s[nstar] + stau)/2 * (tau - all$l[nstar])
  p1 + p2
}


