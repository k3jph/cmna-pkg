## Copyright (c) 2016-2026, James P. Howard, II <jh@jameshoward.us>
## SPDX-License-Identifier: BSD-2-Clause

#' @name findiff
#' @rdname findiff
#'
#' @title Finite Differences
#'
#' @description
#' Approximate derivatives using finite-difference formulas.
#'
#' @param f function to differentiate
#' @param x the point at which to evaluate the derivative (finite numeric
#'   scalar)
#' @param h step size for evaluation (numeric scalar)
#' @param n maximum number of Richardson extrapolation steps in `rdiff`
#'   (positive integer, default 10)
#'
#' @details
#' `findiff` uses the forward-difference formula
#' `(f(x + h) - f(x)) / h` to approximate `f'(x)`.
#'
#' `symdiff` uses the central (symmetric) difference
#' `(f(x + h) - f(x - h)) / (2h)`, which has error O(h^2).
#'
#' `findiff2` approximates the second derivative using the standard
#' three-point stencil `(f(x + h) - 2f(x) + f(x - h)) / h^2`.
#'
#' `rdiff` applies Richardson extrapolation to `symdiff`, recursively
#' combining estimates at halved step sizes up to depth `n`.
#'
#' @return A numeric scalar giving the estimated derivative.
#'
#' @family differentiation
#'
#' @examples
#' findiff(sin, pi, 1e-3)
#' symdiff(sin, pi, 1e-3)
#'
#' @export
findiff <- function(f, x,
               h = x * sqrt(.Machine$double.eps)) {
    .cmna_validate_function(f, "f")
    .cmna_validate_finite_scalar(x, "x")

    return((f(x + h) - f(x)) / h)
}

#' @rdname findiff
#' @export
symdiff <- function(f, x,
               h = x * .Machine$double.eps^(1/3)) {
    .cmna_validate_function(f, "f")
    .cmna_validate_finite_scalar(x, "x")

    return((f(x + h) - f(x - h)) / (2 * h))
}

#' @rdname findiff
#' @export
findiff2 <- function(f, x, h) {
    .cmna_validate_function(f, "f")
    .cmna_validate_finite_scalar(x, "x")

    return((f(x + h) - 2 * f(x) + f(x - h)) / h^2)
}

#' @rdname findiff
#' @export
rdiff <- function(f, x, n = 10, h = 1e-4) {
    .cmna_validate_function(f, "f")
    .cmna_validate_finite_scalar(x, "x")
    .cmna_validate_pos_integer(n, "n")

    if(n == 1)
        return(symdiff(f, x, h = h))

    dx <- (4 * rdiff(f, x, n = n - 1, h = h / 2) -
               symdiff(f, x, h = h)) / 3
    return(dx)
}
