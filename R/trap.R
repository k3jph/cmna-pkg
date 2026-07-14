## Copyright (c) 2016-2026, James P. Howard, II <jh@jameshoward.us>
## SPDX-License-Identifier: BSD-2-Clause

#' @title Trapezoidal rule
#'
#' @description
#' Approximate a definite integral using the composite trapezoidal rule.
#'
#' @param f function to integrate
#' @param a lower bound of integration (finite numeric scalar)
#' @param b upper bound of integration (finite numeric scalar)
#' @param m number of subintervals (positive integer, default 100)
#'
#' @details
#' The trapezoidal rule divides `[a, b]` into `m` equal subintervals
#' and approximates the integral by the sum of trapezoid areas. For a
#' linear integrand the rule is exact; the error for smooth functions
#' is O(h^2) where h = (b - a) / m.
#'
#' @return A numeric scalar approximating the integral.
#'
#' @family integration
#' @family newton-cotes
#'
#' @examples
#' f <- function(x) sin(x)^2 + cos(x)^2
#' trap(f, -pi, pi, m = 100)
#'
#' @export
trap <- function(f, a, b, m = 100) {
    .cmna_validate_function(f, "f")
    .cmna_validate_finite_scalar(a, "a")
    .cmna_validate_finite_scalar(b, "b")
    .cmna_validate_pos_integer(m, "m")

    x <- seq(a, b, length.out = m + 1)
    y <- f(x)

    p.area <- sum(y[2:(m + 1)] + y[1:m])
    p.area * abs(b - a) / (2 * m)
}
