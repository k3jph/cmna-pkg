## Copyright (c) 2016-2026, James P. Howard, II <jh@jameshoward.us>
## SPDX-License-Identifier: BSD-2-Clause

#' @title Piecewise Linear Interpolation
#'
#' @description
#' Find a piecewise linear function that interpolates the data points.
#'
#' @param x a numeric vector of x-coordinates
#' @param y a numeric vector of y-coordinates
#'
#' @details
#' `pwiselinterp` sorts the data by x-coordinate, then finds the unique
#' line interpolating each consecutive pair of points. The result is a
#' list with two vectors of slope and intercept coefficients from the
#' slope-intercept form \eqn{y = mx + b}.
#'
#' @return A list with components `m` (slopes) and `b` (intercepts),
#'   each of length `length(x) - 1`.
#'
#' @family interp
#' @family algebra
#'
#' @examples
#' x <- c(5, 0, 3)
#' y <- c(4, 0, 3)
#' f <- pwiselinterp(x, y)
#'
#' @export
pwiselinterp <- function(x, y) {
    .cmna_validate_numeric_vector(x, "x")
    .cmna_validate_numeric_vector(y, "y")

    n <- length(x) - 1

    y <- y[order(x)]
    x <- x[order(x)]

    mvec <- bvec <- c()

    for(i in 1:n) {
        p <- linterp(x[i], y[i], x[i + 1], y[i + 1])
        mvec <- c(mvec, p[2])
        bvec <- c(bvec, p[1])
    }

    return(list(m = mvec, b = bvec))
}
