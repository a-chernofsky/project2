% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/rmst_ic.R
\name{rmst_ic}
\alias{rmst_ic}
\title{Calculate the restricted mean survival time for interval censored data}
\usage{
rmst_ic(left, right, tau, subset = NULL)
}
\arguments{
\item{left}{numeric vector of left endpoints of censoring interval}

\item{right}{numeric vector of right endpoints of censoring interval}

\item{tau}{time horizon}
}
\value{
numeric
}
\description{
Calculate the restricted mean survival time for interval censored data
}
\examples{
library(interval)
data(bcos)
rmst_ic(bcos$left, bcos$right, tau = 30)
}
