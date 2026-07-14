## Copyright (c) 2016-2026, James P. Howard, II <jh@jameshoward.us>
## SPDX-License-Identifier: BSD-2-Clause

#' @title Hill Climbing
#'
#' @name hillclimbing
#' @rdname hillclimbing
#'
#' @description
#' Use hill climbing to find a local minimum.
#'
#' @param f function to minimize
#' @param x an initial estimate of the minimum (numeric vector)
#' @param h step size for random perturbation (positive numeric scalar,
#'   default 1)
#' @param m maximum number of iterations (positive integer, default 1000)
#'
#' @details
#' Hill climbing is a stochastic optimization method that iteratively
#' perturbs a randomly chosen component of `x` by drawing from a normal
#' distribution with standard deviation `h`. If the perturbation
#' improves the objective value, the new point is accepted. The process
#' repeats for `m` iterations.
#'
#' @return The `x` value of the minimum found.
#'
#' @family optimz
#'
#' @examples
#' f <- function(x) {
#'     (x[1]^2 + x[2] - 11)^2 + (x[1] + x[2]^2 - 7)^2
#' }
#' hillclimbing(f, c(0,0))
#' hillclimbing(f, c(-1,-1))
#' hillclimbing(f, c(10,10))
#'
#' @importFrom stats runif
#' @importFrom stats rnorm

#' @export
hillclimbing <- function(f, x, h = 1, m = 1e3) {
    .cmna_validate_function(f, "f")
    .cmna_validate_numeric_vector(x, "x")
    .cmna_validate_positive_scalar(h, "h")
    .cmna_validate_pos_integer(m, "m")

    n <- length(x)

    xcurr <- x
    ycurr <- f(x)

    for(i in 1:m) {
        xnext <- xcurr
        i <- ceiling(runif(1, 0, n))
        xnext[i] <- rnorm(1, xcurr[i], h)
        ynext <- f(xnext)
        if(ynext < ycurr) {
            xcurr <- xnext
            ycurr <- ynext
        }
    }

    return(xcurr)
}
