## Copyright (c) 2016-2026, James P. Howard, II <jh@jameshoward.us>
## SPDX-License-Identifier: BSD-2-Clause

#' @title Polynomial Interpolation
#'
#' @description
#' Find the polynomial that interpolates the given points.
#'
#' @param x a numeric vector of x-coordinates
#' @param y a numeric vector of y-coordinates
#'
#' @details
#' `polyinterp` constructs the Vandermonde matrix for the given
#' x-coordinates and solves for the polynomial coefficients that
#' interpolate the corresponding y-values. The vectors `x` and `y`
#' must have the same length.
#'
#' @return A numeric vector of polynomial coefficients in ascending
#'   order of degree, suitable for [horner()].
#'
#' @family interp
#' @family algebra
#'
#' @examples
#' x <- c(1, 2, 3)
#' y <- x^2 + 5 * x - 3
#' f <- polyinterp(x, y)
#'
#' @export
polyinterp <- function(x, y) {
    .cmna_validate_numeric_vector(x, "x")
    .cmna_validate_numeric_vector(y, "y")
    if (length(x) != length(y))
        .cmna_abort(
            "`x` and `y` must have the same length",
            "cmna_invalid_argument",
            x_length = length(x),
            y_length = length(y)
        )

    n <- length(x) - 1
    vandermonde <- rep(1, length(x))
    for(i in 1:n) {
        xi <- x^i
        vandermonde <- cbind(vandermonde, xi)
    }
    beta <- solve(vandermonde, y)

    names(beta) <- NULL
    return(beta)
}
