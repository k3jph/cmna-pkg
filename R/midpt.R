## Copyright (c) 2016-2026, James P. Howard, II <jh@jameshoward.us>
## SPDX-License-Identifier: BSD-2-Clause

#' @title Midpoint (rectangle) rule
#'
#' @description
#' Approximate a definite integral using the composite midpoint rule.
#'
#' @param f function to integrate
#' @param a lower bound of integration (finite numeric scalar)
#' @param b upper bound of integration (finite numeric scalar)
#' @param m number of subintervals (positive integer, default 100)
#'
#' @details
#' The midpoint rule divides `[a, b]` into `m` equal subintervals and
#' evaluates `f` at the centre of each subinterval. The error for
#' smooth functions is O(h^2) where h = (b - a) / m.
#'
#' @return A numeric scalar approximating the integral.
#'
#' @family integration
#' @family newton-cotes
#'
#' @examples
#' f <- function(x) sin(x)^2 + cos(x)^2
#' midpt(f, -pi, pi, m = 100)
#'
#' @export
midpt <- function(f, a, b, m = 100) {
    .cmna_validate_function(f, "f")
    .cmna_validate_finite_scalar(a, "a")
    .cmna_validate_finite_scalar(b, "b")
    .cmna_validate_pos_integer(m, "m")

    nwidth <- (b - a) / m
    x <- seq(a, b - nwidth, length.out = m) + nwidth / 2
    y <- f(x)

    sum(y) * abs(b - a) / m
}
