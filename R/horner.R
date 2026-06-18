## Copyright (c) 2016-2026, James P. Howard, II <jh@jameshoward.us>
## SPDX-License-Identifier: BSD-2-Clause

#' @name polynomial-evaluation
#' @rdname polynomial-evaluation
#'
#' @title Polynomial evaluation algorithms
#'
#' @description
#' Evaluate a polynomial by direct powers, cached powers, iterative Horner
#' evaluation, or recursive Horner evaluation.
#'
#' @param x A numeric vector of points at which to evaluate the polynomial.
#' @param coefs A non-empty numeric vector of coefficients in ascending power
#'   order: the first element is the constant term, the second is the
#'   coefficient of x, and so on.
#'
#' @details
#' All four functions use the same coefficient convention. For example,
#' `c(5, -3, 2)` represents `5 - 3*x + 2*x^2`.
#'
#' `naivepoly()` computes each power independently. `betterpoly()` caches the
#' current power of x. `horner()` evaluates iteratively using Horner's rule.
#' `rhorner()` evaluates the same recurrence recursively.
#'
#' The functions accept scalar or vector `x` and return a numeric vector of the
#' same length. Empty `x` returns `numeric(0)`. Coefficients must be non-empty.
#' Non-finite numeric values follow ordinary R arithmetic.
#'
#' @return A numeric vector containing the polynomial value at each element of
#'   `x`.
#'
#' @family algebra
#'
#' @examples
#' coefs <- c(5, -3, 2)
#' horner(c(0, 1, 2), coefs)
#' naivepoly(c(0, 1, 2), coefs)
#'
#' @export
horner <- function(x, coefs) {
    if (!is.numeric(x)) {
        stop("x must be numeric", call. = FALSE)
    }
    if (!is.numeric(coefs) || length(coefs) == 0L) {
        stop("coefs must be a non-empty numeric vector", call. = FALSE)
    }

    y <- rep(0, length(x))
    for (i in rev(seq_along(coefs))) {
        y <- coefs[[i]] + x * y
    }
    y
}

#' @rdname polynomial-evaluation
#' @export
rhorner <- function(x, coefs) {
    if (!is.numeric(x)) {
        stop("x must be numeric", call. = FALSE)
    }
    if (!is.numeric(coefs) || length(coefs) == 0L) {
        stop("coefs must be a non-empty numeric vector", call. = FALSE)
    }

    recurse <- function(index) {
        if (index == length(coefs)) {
            return(rep(coefs[[index]], length(x)))
        }
        coefs[[index]] + x * recurse(index + 1L)
    }

    recurse(1L)
}

#' @rdname polynomial-evaluation
#' @export
naivepoly <- function(x, coefs) {
    if (!is.numeric(x)) {
        stop("x must be numeric", call. = FALSE)
    }
    if (!is.numeric(coefs) || length(coefs) == 0L) {
        stop("coefs must be a non-empty numeric vector", call. = FALSE)
    }

    y <- rep(0, length(x))
    for (i in seq_along(coefs)) {
        y <- y + coefs[[i]] * x^(i - 1L)
    }
    y
}

#' @rdname polynomial-evaluation
#' @export
betterpoly <- function(x, coefs) {
    if (!is.numeric(x)) {
        stop("x must be numeric", call. = FALSE)
    }
    if (!is.numeric(coefs) || length(coefs) == 0L) {
        stop("coefs must be a non-empty numeric vector", call. = FALSE)
    }

    y <- rep(0, length(x))
    cached_x <- rep(1, length(x))
    for (i in seq_along(coefs)) {
        y <- y + coefs[[i]] * cached_x
        cached_x <- cached_x * x
    }
    y
}
