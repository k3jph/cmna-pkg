## Copyright (c) 2016-2026, James P. Howard, II <jh@jameshoward.us>
## SPDX-License-Identifier: BSD-2-Clause

#' @title Simpson's 3/8 rule
#'
#' @description
#' Approximate a definite integral using the composite Simpson's 3/8
#' rule.
#'
#' @param f function to integrate
#' @param a lower bound of integration (finite numeric scalar)
#' @param b upper bound of integration (finite numeric scalar)
#' @param m number of subintervals (positive integer, default 100)
#'
#' @details
#' Simpson's 3/8 rule divides `[a, b]` into `m` subintervals and
#' uses a cubic Newton-Cotes formula on each. The error for smooth
#' functions is O(h^4), the same order as Simpson's rule but with a
#' different constant.
#'
#' @return A numeric scalar approximating the integral.
#'
#' @family integration
#' @family newton-cotes
#'
#' @examples
#' f <- function(x) sin(x)^2 + log(x)
#' simp38(f, 1, 10, m = 100)
#'
#' @export
simp38 <- function(f, a, b, m = 100) {
    .cmna_validate_function(f, "f")
    .cmna_validate_finite_scalar(a, "a")
    .cmna_validate_finite_scalar(b, "b")
    .cmna_validate_pos_integer(m, "m")

    x.ends <- seq(a, b, length.out = m + 1)
    y.ends <- f(x.ends)
    x.midh <- (2 * x.ends[2:(m + 1)] + x.ends[1:m]) / 3
    x.midl <- (x.ends[2:(m + 1)] + 2 * x.ends[1:m]) / 3
    y.midh <- f(x.midh)
    y.midl <- f(x.midl)

    p.area <- sum(y.ends[2:(m + 1)] + 3 * y.midh[1:m] +
                      3 * y.midl[1:m] + y.ends[1:m])
    p.area * abs(b - a) / (8 * m)
}
