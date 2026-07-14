## Copyright (c) 2016-2026, James P. Howard, II <jh@jameshoward.us>
## SPDX-License-Identifier: BSD-2-Clause

#' @title Initial Value Problems for Systems of ODEs
#'
#' @name ivpsys
#'
#' @description
#' Solve initial value problems for systems of ordinary differential
#' equations.
#'
#' @param f a function of two arguments \eqn{(x, y)} returning a numeric
#'   vector of derivatives
#' @param x0 a finite numeric scalar giving the initial x-value
#' @param y0 a numeric vector of initial y-values
#' @param h a positive numeric scalar giving the step size
#' @param n a positive integer giving the number of steps
#'
#' @details
#' `eulersys` implements the Euler method for solving systems of
#' ordinary differential equations. If `y0` is a named vector, the
#' names are preserved in the returned data frame.
#'
#' @return A data frame with a column `x` and one column per component
#'   of the system.
#'
#' @examples
#' f <- function(x, y) { y / (2 * x + 1) }
#' ivp.euler <- euler(f, 0, 1, 1/100, 100)

#' @rdname ivpsys
#' @export
eulersys <- function(f, x0, y0, h, n) {
    .cmna_validate_function(f, "f")
    .cmna_validate_finite_scalar(x0, "x0")
    .cmna_validate_numeric_vector(y0, "y0")
    .cmna_validate_positive_scalar(h, "h")
    .cmna_validate_pos_integer(n, "n")

    x <- x0
    y <- y0

    ## If y0 values are named, the data frame names them!
    ## The value names produced by f(x, y) should match.
    values <- data.frame(x = x, t(y0))
    for(i in 1:n) {
        y0 <- y0 + h * f(x0, y0)
        x0 <- x0 + h
        values <- rbind(values, data.frame(x = x0, t(y0)))
    }

    return(values)
}
