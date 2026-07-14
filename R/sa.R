## Copyright (c) 2016-2026, James P. Howard, II <jh@jameshoward.us>
## SPDX-License-Identifier: BSD-2-Clause

#' @title Simulated Annealing
#'
#' @name sa
#'
#' @description
#' Use simulated annealing to find the global minimum.
#'
#' @param f function to minimize
#' @param x an initial estimate of the minimum (numeric vector for `sa`,
#'   numeric matrix of point coordinates for `tspsa`)
#' @param temp initial temperature (positive numeric scalar)
#' @param rate cooling rate (positive numeric scalar between 0 and 1)
#'
#' @details
#' Simulated annealing finds a global minimum by mimicking the
#' metallurgical process of annealing. At each step a random
#' perturbation is proposed and accepted if it improves the objective
#' or with probability depending on the current temperature.
#'
#' `sa` performs general-purpose simulated annealing on a numeric
#' vector. `tspsa` solves the travelling salesman problem on a matrix
#' of point coordinates, returning the best tour order and its total
#' distance.
#'
#' @return For `sa`, the `x` value of the minimum found. For `tspsa`,
#'   a list with components `order` (the best tour) and `distance`
#'   (the total tour distance).
#'
#' @family optimz
#'
#' @examples
#' f <- function(x) { x^6 - 4 * x^5 - 7 * x^4 + 22 * x^3 + 24 * x^2 + 2}
#' sa(f, 0)
#'
#' f <- function(x) { (x[1] - 1)^2 + (x[2] - 1)^2 }
#' sa(f, c(0, 0), 0.05)
#'
#' @importFrom stats runif
#' @importFrom stats rnorm
#'
#' @rdname sa
#' @export
sa <- function(f, x, temp = 1e4, rate = 1e-4) {
    .cmna_validate_function(f, "f")
    .cmna_validate_numeric_vector(x, "x")
    .cmna_validate_positive_scalar(temp, "temp")
    .cmna_validate_positive_scalar(rate, "rate")

    step = 1 - rate
    n <- length(x)

    xbest <- xcurr <- xnext <- x
    ybest <- ycurr <- ynext <- f(x)

    while(temp > 1) {
        temp <- temp * step
        i <- ceiling(runif(1, 0, n))
        xnext[i] <- rnorm(1, xcurr[i], temp)
        ynext <- f(xnext)
        accept <- exp(-(ynext - ycurr) / temp)
        if(ynext < ycurr || runif(1) < accept) {
            xcurr <- xnext
            ycurr <- ynext
        }
        if(ynext < ybest) {
            xbest <- xcurr
            ybest <- ycurr
        }
    }

    return(xbest)
}

#' @rdname sa
#' @export
tspsa <- function(x, temp = 1e2, rate = 1e-4) {
    if (!is.matrix(x))
        .cmna_abort(
            "`x` must be a numeric matrix",
            "cmna_invalid_argument",
            arg = "x"
        )
    .cmna_validate_positive_scalar(temp, "temp")
    .cmna_validate_positive_scalar(rate, "rate")

    step = 1 - rate
    n <- nrow(x)

    xbest <- xcurr <- xnext <- c(1:n)
    ynext <- 0
    for(i in 2:n) {
        a <- xnext[i - 1]
        b <- xnext[i]
        ynext <- ynext + vecnorm(x[a,] - x[b,])
    }
    a <- xnext[1]
    b <- xnext[n]
    ynext <- ynext + vecnorm(x[a,] - x[b,])
    ybest <- ycurr <- ynext

    while(temp > 1) {
        temp <- temp * step
        i <- ceiling(runif(1, 1, n))
        xnext <- xcurr
        temporary <- xnext[i]
        xnext[i] <- xnext[i - 1]
        xnext[i - 1] <- temporary
        ynext <- 0
        for(i in 2:n) {
          a <- xnext[i - 1]
          b <- xnext[i]
          ynext <- ynext + vecnorm(x[a,] - x[b,])
        }
        a <- xnext[1]
        b <- xnext[n]
        ynext <- ynext + vecnorm(x[a,] - x[b,])
        accept <- exp(-(ynext - ycurr) / temp)
        if(ynext < ycurr || runif(1) < accept) {
            xcurr <- xnext
            ycurr <- ynext
        }
        if(ynext < ybest) {
            xbest <- xcurr
            ybest <- ycurr
        }
    }
    return(list(order = xbest, distance = ybest))
}
