% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/sim_interval.R
\name{sim_interval}
\alias{sim_interval}
\title{Simulate interval censored data}
\usage{
sim_interval(t, pmiss, visits)
}
\arguments{
\item{t}{vector of times-to-event}

\item{pmiss}{probability of missing a study visit}

\item{visits}{a vector of study visit times}
}
\value{
data.frame
}
\description{
Simulates intervals for time-to-event data based on a study visit schedule
}
\examples{
T <- rexp(10, 0.5)
sim_interval(T, 0.10, c(0, 1, 2, 3, 4))
}
