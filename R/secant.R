## Copyright (c) 2016, James P. Howard, II <jh@jameshoward.us>
##
## Redistribution and use in source and binary forms, with or without
## modification, are permitted provided that the following conditions are
## met:
##
##     Redistributions of source code must retain the above copyright
##     notice, this list of conditions and the following disclaimer.
##
##     Redistributions in binary form must reproduce the above copyright
##     notice, this list of conditions and the following disclaimer in
##     the documentation and/or other materials provided with the
##     distribution.
##
## THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
## "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
## LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
## A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
## HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
## SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
## LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
## DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
## THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
## (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
## OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#' @title Secant Method
#'
#' @description
#' Locate a real root of a function using the secant method.
#'
#' @param f A function of one numeric argument.
#' @param x0 A finite numeric scalar giving the first initial estimate.
#' @param x1 A finite numeric scalar giving the second initial estimate.
#' @param tol A positive finite numeric tolerance for the change between
#'   successive estimates.
#' @param m A positive whole number giving the maximum number of iterations.
#'
#' @details
#' The secant method approximates the derivative in Newton's method using two
#' successive estimates. The function returns immediately if either initial
#' estimate is already an exact root. Otherwise, iteration stops when the
#' absolute change between successive estimates is no greater than \code{tol}.
#'
#' The function signals an error if the initial estimates are identical, the
#' secant denominator is zero, an intermediate value is non-finite, the
#' iteration ceases to advance in floating-point arithmetic before convergence,
#' or the iteration limit is exhausted.
#'
#' @return A numeric approximation to a real root of \code{f}.
#'
#' @family optimization
#'
#' @examples
#' f <- function(x) x^3 - 2 * x^2 - 159 * x - 540
#' secant(f, 1, 2)
#'
#' @export
secant <- function(f, x0, x1, tol = 1e-3, m = 100) {
    if (!is.function(f)) {
        stop("f must be a function", call. = FALSE)
    }
    if (!is.numeric(x0) || length(x0) != 1L || !is.finite(x0)) {
        stop("x0 must be a finite numeric scalar", call. = FALSE)
    }
    if (!is.numeric(x1) || length(x1) != 1L || !is.finite(x1)) {
        stop("x1 must be a finite numeric scalar", call. = FALSE)
    }
    if (x0 == x1) {
        stop("x0 and x1 must be distinct", call. = FALSE)
    }
    if (!is.numeric(tol) || length(tol) != 1L || !is.finite(tol) || tol <= 0) {
        stop("tol must be a positive finite numeric scalar", call. = FALSE)
    }
    if (!is.numeric(m) || length(m) != 1L || !is.finite(m) || m < 1 || m != floor(m)) {
        stop("m must be a positive whole number", call. = FALSE)
    }

    f0 <- f(x0)
    if (!is.numeric(f0) || length(f0) != 1L || !is.finite(f0)) {
        stop("f(x0) must be a finite numeric scalar", call. = FALSE)
    }
    if (f0 == 0) {
        return(x0)
    }

    f1 <- f(x1)
    if (!is.numeric(f1) || length(f1) != 1L || !is.finite(f1)) {
        stop("f(x1) must be a finite numeric scalar", call. = FALSE)
    }
    if (f1 == 0) {
        return(x1)
    }

    for (iter in seq_len(m)) {
        denominator <- f1 - f0
        if (denominator == 0) {
            stop("secant denominator is zero", call. = FALSE)
        }

        next_x <- x1 - f1 * (x1 - x0) / denominator
        if (!is.numeric(next_x) || length(next_x) != 1L || !is.finite(next_x)) {
            stop("next estimate must be a finite numeric scalar", call. = FALSE)
        }

        step <- abs(next_x - x1)
        if (step <= tol) {
            return(next_x)
        }
        if (next_x == x1) {
            stop("secant iteration can no longer advance in floating-point arithmetic",
                 call. = FALSE)
        }

        x0 <- x1
        f0 <- f1
        x1 <- next_x
        f1 <- f(x1)
        if (!is.numeric(f1) || length(f1) != 1L || !is.finite(f1)) {
            stop("f(x1) must be a finite numeric scalar", call. = FALSE)
        }
        if (f1 == 0) {
            return(x1)
        }
    }

    stop("maximum number of iterations exceeded", call. = FALSE)
}
