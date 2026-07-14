## Copyright (c) 2016-2026, James P. Howard, II <jh@jameshoward.us>
## SPDX-License-Identifier: BSD-2-Clause

#' @name mcint
#' @rdname mcint
#'
#' @title Monte Carlo Integration
#'
#' @description
#' Estimate definite integrals by Monte Carlo sampling.
#'
#' @param f function to integrate
#' @param a lower bound of integration (finite numeric scalar)
#' @param b upper bound of integration (finite numeric scalar)
#' @param xdom the domain on `x` of integration in two dimensions
#' @param ydom the domain on `y` of integration in two dimensions
#' @param m number of random sample points (positive integer, default 1000)
#'
#' @details
#' `mcint` draws `m` points uniformly on `[a, b]`, evaluates `f` at
#' each, and returns `(b - a)` times the sample mean. `mcint2` extends
#' this to two dimensions: `m` points are drawn uniformly over the
#' rectangular domain defined by `xdom` and `ydom`, and the volume
#' estimate is the domain area times the sample mean of `f(x, y)`.
#'
#' @return A numeric scalar giving the estimated integral (or volume).
#'
#' @family integration
#'
#' @examples
#' f <- function(x) { sin(x)^2 + log(x)}
#' mcint(f, 0, 1)
#' mcint(f, 0, 1, m = 10e6)
#'
#' @importFrom stats runif
#'
#' @export
mcint <- function(f, a, b, m = 1000) {
    .cmna_validate_function(f, "f")
    .cmna_validate_finite_scalar(a, "a")
    .cmna_validate_finite_scalar(b, "b")
    .cmna_validate_pos_integer(m, "m")

    x <- runif(m, min = a, max = b)

    y.hat <- f(x)
    area <- (b - a) * sum(y.hat) / m
    return(area)
}

#' @rdname mcint
#' @export
mcint2 <- function(f, xdom, ydom, m = 1000) {
    .cmna_validate_function(f, "f")
    .cmna_validate_pos_integer(m, "m")

    xmin <- min(xdom)
    xmax <- max(xdom)
    ymin <- min(ydom)
    ymax <- max(ydom)

    x <- runif(m, min = xmin, max = xmax)
    y <- runif(m, min = ymin, max = ymax)

    z.hat <- f(x, y)
    V = (xmax - xmin) * (ymax - ymin)
    volume = V * sum(z.hat) / m
    return(volume)
}
