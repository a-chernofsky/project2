#' Simulate interval censored data
#'
#' Simulates intervals for time-to-event data based on a study visit schedule
#'
#' @param t vector of times-to-event
#' @param pmiss probability of missing a study visit
#' @param visits a vector of study visit times
#'
#' @return data.frame
#' @export
#'
#' @examples
#' T <- rexp(10, 0.5)
#' sim_interval(T, 0.10, c(0, 1, 2, 3, 4))
sim_interval <- function(t, pmiss, visits){
  #matrix of subject's study visit attendance
  miss <- matrix(stats::rbinom(length(visits)*length(t), 1, 1-pmiss), nrow = length(t), ncol = length(visits))
  #convert values of 0 to missing
  miss[miss == 0] <- NA
  #assume all subjects attend the first exam
  miss[,1] <- 1
  #matrix of study visits
  visit_mat <- sweep(miss, MARGIN=2, visits, `*`)
  #calculate the left interval endpoint
  l <- sapply(1:length(t),
              function(x)ifelse(t[x] < visits[1],
                                -Inf,
                                visit_mat[x,][max(which(t[x] > visit_mat[x,]), na.rm = T)]))
  #right interval endpoint
  r <- sapply(1:length(t),
              function(x)ifelse(t[x] > visits[length(visits)] | t[x] > max(visit_mat[x,][!is.na(visit_mat[x,])]),
                                Inf,
                                visit_mat[x,][min(which(t[x] <= visit_mat[x,]), na.rm = T)]))
  #output data.frame
  data.frame(t = t, l = l, r = r)
}
