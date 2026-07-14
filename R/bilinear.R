## Copyright (c) 2016-2026, James P. Howard, II <jh@jameshoward.us>
## SPDX-License-Identifier: BSD-2-Clause

#' @title Bilinear Interpolation
#'
#' @description
#' Compute a bilinear interpolation bounded by four corner points.
#'
#' @param x a numeric vector of length 2 giving \eqn{x_1} and \eqn{x_2}
#' @param y a numeric vector of length 2 giving \eqn{y_1} and \eqn{y_2}
#' @param z a 2-by-2 numeric matrix of z-values at the four corners
#' @param newx a numeric vector of x-coordinates at which to interpolate
#' @param newy a numeric vector of y-coordinates at which to interpolate
#'
#' @details
#' `bilinear` performs bilinear interpolation within the rectangle
#' defined by the corners \eqn{(x_1, y_1)} and \eqn{(x_2, y_2)}.
#' First the function interpolates along the x-axis, then along the
#' y-axis.
#'
#' @return A numeric vector of interpolated z-values.
#'
#' @family interp
#' @family algebra
#'
#' @examples
#' x <- c(2, 4)
#' y <- c(4, 7)
#' z <- matrix(c(81, 84, 85, 89), nrow = 2)
#' newx <- c(2.5, 3, 3.5)
#' newy <- c(5, 5.5, 6)
#' bilinear(x, y, z, newx, newy)
#'
#' @export
bilinear <- function(x, y, z, newx, newy) {
    .cmna_validate_numeric_vector(x, "x")
    .cmna_validate_numeric_vector(y, "y")
    .cmna_validate_matrix(z, "z")
    .cmna_validate_numeric_vector(newx, "newx")
    .cmna_validate_numeric_vector(newy, "newy")

    ## Find intermediate values along the x-axis, first
    z1 <- (x[2] - newx) * z[1,1] + (newx - x[1]) * z[1,2]
    z1 <- z1 / (x[2] - x[1])
    z2 <- (x[2] - newx) * z[2,1] + (newx - x[1]) * z[2,2]
    z2 <- z2 / (x[2] - x[1])

    ## Then interpolate along the y-axis
    z <- (y[2] - newy) * z1 + (newy - y[1]) * z2
    z <- z / (y[2] - y[1])

    return(z)
}
