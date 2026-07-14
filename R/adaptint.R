## Copyright (c) 2016-2026, James P. Howard, II <jh@jameshoward.us>
## SPDX-License-Identifier: BSD-2-Clause

#' @title Adaptive Integration
#'
#' @description
#' Approximate a definite integral using adaptive subdivision.
#'
#' @param f function to integrate
#' @param a lower bound of integration (finite numeric scalar)
#' @param b upper bound of integration (finite numeric scalar)
#' @param n maximum recursive depth (positive integer, default 10)
#' @param tol error tolerance (positive numeric scalar, default 1e-6)
#'
#' @details
#' `adaptint` recursively subdivides `[a, b]` and uses the midpoint
#' rule on each subinterval. When two successive midpoint estimates
#' differ by more than `3 * tol`, the interval is halved and each half
#' is integrated with reduced depth and tighter tolerance. Recursion
#' stops when the estimates agree or the depth limit `n` is reached.
#'
#' @return A numeric scalar approximating the integral.
#'
#' @family integration
#' @family newton-cotes
#' @family adaptive
#'
#' @examples
#' f <- function(x) { sin(x)^2 + log(x) }
#' adaptint(f, 1, 10, n = 4)
#' adaptint(f, 1, 10, n = 5)
#' adaptint(f, 1, 10, n = 10)
#'
#' @export
adaptint <- function(f, a, b, n = 10, tol = 1e-6) {
    .cmna_validate_function(f, "f")
    .cmna_validate_finite_scalar(a, "a")
    .cmna_validate_finite_scalar(b, "b")
    .cmna_validate_pos_integer(n, "n")
    .cmna_validate_tolerance(tol)

    if(n == 1)
        area <- midpt(f, a, b, m = 2)
    else {
        q1 <- midpt(f, a, b, m = 1)
        q2 <- midpt(f, a, b, m = 2)
        if(abs(q1 - q2) > 3 * tol) {
            n = n - 1
            tol <- tol / 2
            c <- (a + b) / 2
            lt <- adaptint(f, a, c, n = n, tol = tol)
            rt <- adaptint(f, c, b, n = n, tol = tol)
            area <- lt + rt
        } else
            area <- q2
    }

    return(area)
}
