#' Calculate pseudo-values for restricted mean survival time
#'
#' @param time
#' @param event
#' @param left
#' @param right
#' @param tau
#' @param censor
#'
#' @return
#' @export
#'
#' @examples
pseudo_rmst <- function(time, event, left = NULL, right = NULL, tau, censor = "right"){
  #check that a valid type of censoring is inputted
  if(!(censor %in% c("right", "interval")))stop("A valid censoring type must be provided: try 'right' or 'interval'")

  #calculate pseudo-values for right censored data
  if(censor == "right"){
    u <- numeric(length(time))
    for(i in 1:length(u)){
      u[i] <- rmst_rc(time, event, tau, subset = -i)
    }
  }

  #calculate pseduo-values for interval censored data
  else if(censor == "interval"){
    u <- numeric(length(left))
    for(i in 1:length(u)){
      u[i] <- rmst_ic(left, right, tau, subset = -i)
    }
  }
  u
}
