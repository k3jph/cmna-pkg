## Copyright (c) 2016-2026, James P. Howard, II <jh@jameshoward.us>
## SPDX-License-Identifier: BSD-2-Clause

#' @title Linear Interpolation
#'
#' @description
#' Find the linear function passing through two points.
#'
#' @param x1 a finite numeric scalar giving the x-coordinate of the first point
#' @param y1 a finite numeric scalar giving the y-coordinate of the first point
#' @param x2 a finite numeric scalar giving the x-coordinate of the second point
#' @param y2 a finite numeric scalar giving the y-coordinate of the second point
#'
#' @details
#' `linterp` computes the coefficients of the unique linear function
#' passing through the two points \eqn{(x_1, y_1)} and \eqn{(x_2, y_2)}.
#' The coefficients are returned in a form suitable for [horner()].
#'
#' @return A numeric vector of length 2 giving the intercept and slope.
#'
#' @family interp
#' @family algebra
#'
#' @examples
#' f <- linterp(3, 2, 7, -2)
#'
#' @export
linterp <- function(x1, y1, x2, y2) {
    .cmna_validate_finite_scalar(x1, "x1")
    .cmna_validate_finite_scalar(y1, "y1")
    .cmna_validate_finite_scalar(x2, "x2")
    .cmna_validate_finite_scalar(y2, "y2")

    m <- (y2 - y1) / (x2 - x1)
    b <- y2 - m * x2

    ## Convert into a form suitable for horner()
    return(c(b, m))
}
