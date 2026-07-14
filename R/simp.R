## Copyright (c) 2016-2026, James P. Howard, II <jh@jameshoward.us>
## SPDX-License-Identifier: BSD-2-Clause

#' @title Simpson's rule
#'
#' @description
#' Approximate a definite integral using the composite Simpson's rule.
#'
#' @param f function to integrate
#' @param a lower bound of integration (finite numeric scalar)
#' @param b upper bound of integration (finite numeric scalar)
#' @param m number of subintervals (positive integer, default 100)
#'
#' @details
#' Simpson's rule divides `[a, b]` into `m` subintervals and
#' approximates the integral using a quadratic interpolation on each
#' subinterval. The rule integrates polynomials up to degree 3 exactly.
#' The error for smooth functions is O(h^4).
#'
#' @return A numeric scalar approximating the integral.
#'
#' @family integration
#' @family newton-cotes
#'
#' @examples
#' f <- function(x) sin(x)^2 + cos(x)^2
#' simp(f, -pi, pi, m = 100)
#'
#' @export
simp <- function(f, a, b, m = 100) {
    .cmna_validate_function(f, "f")
    .cmna_validate_finite_scalar(a, "a")
    .cmna_validate_finite_scalar(b, "b")
    .cmna_validate_pos_integer(m, "m")

    x.ends <- seq(a, b, length.out = m + 1)
    y.ends <- .cmna_eval_vectorized(f, x.ends)
    x.mids <- (x.ends[2:(m + 1)] - x.ends[1:m]) / 2 + x.ends[1:m]
    y.mids <- .cmna_eval_vectorized(f, x.mids)

    p.area <- sum(y.ends[2:(m + 1)] + 4 * y.mids[1:m] + y.ends[1:m])
    p.area * abs(b - a) / (6 * m)
}
