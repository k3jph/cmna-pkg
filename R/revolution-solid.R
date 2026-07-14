## Copyright (c) 2016-2026, James P. Howard, II <jh@jameshoward.us>
## SPDX-License-Identifier: BSD-2-Clause

#' @name revolution-solid
#' @rdname revolution-solid
#'
#' @title Volumes of Solids of Revolution
#'
#' @description
#' Find the volume of a solid of revolution using the shell or disc
#' method.
#'
#' @param f function defining the curve to revolve
#' @param a lower bound of the solid (finite numeric scalar)
#' @param b upper bound of the solid (finite numeric scalar)
#'
#' @details
#' `shellmethod` computes the volume of the solid obtained by revolving
#' the curve `f(x)` about the *y*-axis on `[a, b]` using the
#' cylindrical-shell formula `2 * pi * integral(x * f(x))`.
#'
#' `discmethod` computes the volume of the solid obtained by revolving
#' `f(x)` about the *x*-axis on `[a, b]` using the disc formula
#' `integral(pi * f(x)^2)`.
#'
#' @return A numeric scalar giving the volume of the solid.
#'
#' @family integration
#'
#' @examples
#' f <- function(x) { x^2 }
#' shellmethod(f, 1, 2)
#' discmethod(f, 1, 2)
#'
#' @export
shellmethod <- function(f, a, b) {
    .cmna_validate_function(f, "f")
    .cmna_validate_finite_scalar(a, "a")
    .cmna_validate_finite_scalar(b, "b")

    solid <- function(x) { return(x * f(x)) }

    return(2 * pi * trap(solid, a, b))
}

#' @rdname revolution-solid
#' @export
discmethod <- function(f, a, b) {
    .cmna_validate_function(f, "f")
    .cmna_validate_finite_scalar(a, "a")
    .cmna_validate_finite_scalar(b, "b")

    solid <- function(x) { return(pi * (f(x))^2) }

    return(midpt(solid, a, b))
}
