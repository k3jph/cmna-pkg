## Copyright (c) 2016-2026, James P. Howard, II <jh@jameshoward.us>
## SPDX-License-Identifier: BSD-2-Clause

#' @title Romberg Integration
#'
#' @description
#' Approximate a definite integral using Romberg's method.
#'
#' @param f function to integrate
#' @param a lower bound of integration (finite numeric scalar)
#' @param b upper bound of integration (finite numeric scalar)
#' @param m number of Richardson extrapolation levels (positive integer)
#' @param tab if `TRUE`, return the full Romberg table instead of just
#'   the final estimate
#'
#' @details
#' Romberg integration applies Richardson extrapolation to successive
#' refinements of the composite trapezoidal rule. At each level `j` the
#' trapezoidal estimate with `2^(j-1)` subintervals is combined with
#' earlier estimates to cancel leading error terms, yielding
#' progressively higher-order approximations. The parameter `m` controls
#' how many levels of extrapolation are performed.
#'
#' @return A numeric scalar giving the integral estimate, or (when
#'   `tab = TRUE`) the full m-by-m Romberg table as a matrix.
#'
#' @family integration
#' @family newton-cotes
#'
#' @examples
#' f <- function(x) { sin(x)^2 + log(x)}
#' romberg(f, 1, 10, m = 3)
#' romberg(f, 1, 10, m = 5)
#' romberg(f, 1, 10, m = 10)
#'
#' @export
romberg <- function(f, a, b, m, tab = FALSE) {
    .cmna_validate_function(f, "f")
    .cmna_validate_finite_scalar(a, "a")
    .cmna_validate_finite_scalar(b, "b")
    .cmna_validate_pos_integer(m, "m")

    R <- matrix(NA, nrow = m, ncol = m)

    R[1, 1] <- trap(f, a, b, m = 1)
    for(j in 2:m) {
        R[j, 1] <- trap(f, a, b, m = 2^(j - 1))
        for(k in 2:j) {
            k4 <- 4^(k - 1)
            R[j, k] <- k4 * R[j, k - 1] - R[j - 1, k - 1]
            R[j, k] <- R[j, k] / (k4 - 1)
        }
    }

    if(tab == TRUE)
        return(R)
    return(R[m, m])
}
