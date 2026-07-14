## Copyright (c) 2016-2026, James P. Howard, II <jh@jameshoward.us>
## SPDX-License-Identifier: BSD-2-Clause

#' @name bezier
#'
#' @title Bezier Curves
#'
#' @description
#' Compute quadratic and cubic Bezier curves for the given control points.
#'
#' @param x a numeric vector of x-coordinates for the control points
#' @param y a numeric vector of y-coordinates for the control points
#' @param t a numeric vector of parameter values at which to evaluate the curve
#'
#' @details
#' `qbezier` computes the quadratic Bezier curve through three control
#' points and `cbezier` computes the cubic Bezier curve through four
#' control points. The curve is evaluated at all values in the vector
#' `t`, which typically ranges from 0 to 1.
#'
#' @return A list with components `x` and `y`, each a numeric vector
#'   of the same length as `t`.
#'
#' @family interp
#'
#' @examples
#' x <- c(1, 2, 3)
#' y <- c(2, 3, 5)
#' f <- qbezier(x, y, seq(0, 1, 1/100))
#'
#' x <- c(-1, 1, 0, -2)
#' y <- c(-2, 2, -1, -1)
#' f <- cbezier(x, y, seq(0, 1, 1/100))
#'
#' @rdname bezier
#' @export
qbezier <- function(x, y, t) {
    .cmna_validate_numeric_vector(x, "x")
    .cmna_validate_numeric_vector(y, "y")
    .cmna_validate_numeric_vector(t, "t")
    if (length(x) != 3 || length(y) != 3)
        .cmna_abort(
            "`x` and `y` must each contain exactly 3 values",
            "cmna_invalid_argument",
            x_length = length(x),
            y_length = length(y)
        )

    newx <- (1-t)^2 * x[1] + 2 * (1-t) * t * x[2] +
        t^2 * x[3]
    newy <- (1-t)^2 * y[1] + 2 * (1-t) * t * y[2] +
        t^2 * y[3]

    return(list(x = newx, y = newy))
}

#' @rdname bezier
#' @export
cbezier <- function(x, y, t) {
    .cmna_validate_numeric_vector(x, "x")
    .cmna_validate_numeric_vector(y, "y")
    .cmna_validate_numeric_vector(t, "t")
    if (length(x) != 4 || length(y) != 4)
        .cmna_abort(
            "`x` and `y` must each contain exactly 4 values",
            "cmna_invalid_argument",
            x_length = length(x),
            y_length = length(y)
        )

    newx <- (1-t)^3 * x[1] + 3 * (1-t)^2 * t * x[2] +
        3 * (1-t) * t^2 * x[3] + t^3 * x[4]
    newy <- (1-t)^3 * y[1] + 3 * (1-t)^2 * t * y[2] +
        3 * (1-t) * t^2 * y[3] + t^3 * y[4]

    return(list(x = newx, y = newy))
}
