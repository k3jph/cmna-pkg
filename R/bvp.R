## Copyright (c) 2016-2026, James P. Howard, II <jh@jameshoward.us>
## SPDX-License-Identifier: BSD-2-Clause

#' @title Boundary Value Problem Example
#'
#' @name bvp
#'
#' @description
#' Example functions for solving boundary value problems via the
#' shooting method.
#'
#' @param x a finite numeric scalar giving the proposed initial slope
#'
#' @details
#' `bvpexample` solves a boundary value problem using the shooting
#' method with [eulersys()]. The ODE system is \eqn{y'' = y^2 - 2}
#' with boundary conditions \eqn{y(0) = 1} and \eqn{y(1) = 1}. The
#' parameter `x` is the trial value for \eqn{y'(0)}. The return value
#' is the residual at \eqn{x = 1}, suitable for use with a root-finding
#' method such as [bisection()] or [secant()].
#'
#' `bvpexample10` is the same problem solved with 10 steps instead of
#' 1000, for faster but less accurate evaluation.
#'
#' @return The residual \eqn{y(1) - 1} for the given trial slope.
#'
#' @examples
#' bvpexample(-2)
#' bvpexample(-1)
#' bvpexample(0)
#' bvpexample(1)
#' bvpexample(2)
#' ## (bvp.b <- bisection(bvpexample, 0, 1))
#' ## (bvp.s <- secant(bvpexample, 0))
#'
#' @importFrom utils tail
#'
#' @rdname bvp
#' @export
bvpexample <- function(x) {
    .cmna_validate_finite_scalar(x, "x")

    x0 <- 0
    y0 <- c(y1 = 1, y2 = x)
    yn <- 1

    odesystem <- function(x, y) {
        y1 <- y[2]
        y2 <- y[1]^2 - 2

        return(c(y1 = y1, y2 = y2))
    }

    z <- eulersys(odesystem, x0, y0, 1 / 1000, 1000)
    tail(z$y1, 1) - yn
}

#' @rdname bvp
#' @export
bvpexample10 <- function(x) {
    .cmna_validate_finite_scalar(x, "x")

    x0 <- 0
    y0 <- c(y1 = 1, y2 = x)
    yn <- 1

    odesystem <- function(x, y) {
        y1 <- y[2]
        y2 <- y[1]^2 - 2

        return(c(y1 = y1, y2 = y2))
    }

    z <- eulersys(odesystem, x0, y0, 1/ 10, 10)
    tail(z$y1, 1) - yn
}
