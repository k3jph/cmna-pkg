## Copyright (c) 2016-2026, James P. Howard, II <jh@jameshoward.us>
## SPDX-License-Identifier: BSD-2-Clause

#' @title Gaussian Integration
#'
#' @description
#' Evaluate integrals using Gaussian quadrature.
#'
#' @param f function to integrate
#' @param m number of evaluation points (positive integer, default 5)
#' @param x vector of evaluation points (abscissae)
#' @param w vector of quadrature weights
#'
#' @details
#' `gaussint` is a low-level driver that evaluates `f` at the supplied
#' points `x` and returns the weighted sum using weights `w`.
#'
#' `gauss.legendre`, `gauss.laguerre`, and `gauss.hermite` are
#' convenience wrappers that look up the pre-computed nodes and weights
#' for the corresponding orthogonal-polynomial family with `m` points.
#' The lookup uses `eval(parse(...))` to resolve the stored parameter
#' sets by name; this is intentional for pedagogical purposes.
#'
#' @return A numeric scalar giving the value of the integral.
#'
#' @family integration
#'
#' @examples
#' w = c(1, 1)
#' x = c(-1 / sqrt(3), 1 / sqrt(3))
#' f <- function(x) { x^3 + x + 1 }
#' gaussint(f, x, w)
#'
#' @export
gaussint <- function(f, x, w) {
    .cmna_validate_function(f, "f")

    y <- .cmna_eval_vectorized(f, x)

    return(sum(y * w))
}

#' @rdname gaussint
#' @export
gauss.legendre <- function(f, m = 5) {
    .cmna_validate_function(f, "f")
    .cmna_validate_pos_integer(m, "m")

    p <- paste("gauss.legendre.", m, sep = "")
    params <- eval(parse(text = p))

    return(gaussint(f, params$x, params$w))
}

#' @rdname gaussint
#' @export
gauss.laguerre <- function(f, m = 5) {
    .cmna_validate_function(f, "f")
    .cmna_validate_pos_integer(m, "m")

    p <- paste("gauss.laguerre.", m, sep = "")
    params <- eval(parse(text = p))

    return(gaussint(f, params$x, params$w))
}

#' @rdname gaussint
#' @export
gauss.hermite <- function(f, m = 5) {
    .cmna_validate_function(f, "f")
    .cmna_validate_pos_integer(m, "m")

    p <- paste("gauss.hermite.", m, sep = "")
    params <- eval(parse(text = p))

    return(gaussint(f, params$x, params$w))
}
