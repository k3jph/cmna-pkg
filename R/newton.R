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

#' @title Newton's Method
#'
#' @description
#' Locate a real root of a differentiable function using Newton iteration.
#'
#' @param f A function of one numeric argument.
#' @param fp A function giving the derivative of \code{f}.
#' @param x A finite numeric scalar giving the initial estimate.
#' @param tol A positive finite numeric tolerance for the change between
#'   successive estimates.
#' @param m A positive whole number giving the maximum number of iterations.
#'
#' @details
#' Newton's method updates the current estimate according to
#' \deqn{x_{n+1} = x_n - f(x_n) / f'(x_n).}
#'
#' The function returns immediately when the initial estimate is already an
#' exact root. Otherwise, iteration stops when the absolute change between two
#' successive estimates is no greater than \code{tol}. The function signals an
#' error if the derivative is zero, an intermediate value is non-finite, the
#' estimate ceases to change in floating-point arithmetic before convergence,
#' or the iteration limit is exhausted.
#'
#' @return A numeric approximation to a real root of \code{f}.
#'
#' @family optimization
#'
#' @examples
#' f <- function(x) x^3 - 2 * x^2 - 159 * x - 540
#' fp <- function(x) 3 * x^2 - 4 * x - 159
#' newton(f, fp, 1)
#'
#' @export
newton <- function(f, fp, x, tol = 1e-3, m = 100) {
    if (!is.function(f)) {
        stop("f must be a function", call. = FALSE)
    }
    if (!is.function(fp)) {
        stop("fp must be a function", call. = FALSE)
    }
    if (!is.numeric(x) || length(x) != 1L || !is.finite(x)) {
        stop("x must be a finite numeric scalar", call. = FALSE)
    }
    if (!is.numeric(tol) || length(tol) != 1L || !is.finite(tol) || tol <= 0) {
        stop("tol must be a positive finite numeric scalar", call. = FALSE)
    }
    if (!is.numeric(m) || length(m) != 1L || !is.finite(m) || m < 1 || m != floor(m)) {
        stop("m must be a positive whole number", call. = FALSE)
    }

    fx <- f(x)
    if (!is.numeric(fx) || length(fx) != 1L || !is.finite(fx)) {
        stop("f(x) must be a finite numeric scalar", call. = FALSE)
    }
    if (fx == 0) {
        return(x)
    }

    for (iter in seq_len(m)) {
        fpx <- fp(x)
        if (!is.numeric(fpx) || length(fpx) != 1L || !is.finite(fpx)) {
            stop("fp(x) must be a finite numeric scalar", call. = FALSE)
        }
        if (fpx == 0) {
            stop("derivative is zero at the current estimate", call. = FALSE)
        }

        next_x <- x - fx / fpx
        if (!is.numeric(next_x) || length(next_x) != 1L || !is.finite(next_x)) {
            stop("next estimate must be a finite numeric scalar", call. = FALSE)
        }

        step <- abs(next_x - x)
        if (step <= tol) {
            return(next_x)
        }
        if (next_x == x) {
            stop("Newton iteration can no longer advance in floating-point arithmetic",
                 call. = FALSE)
        }

        x <- next_x
        fx <- f(x)
        if (!is.numeric(fx) || length(fx) != 1L || !is.finite(fx)) {
            stop("f(x) must be a finite numeric scalar", call. = FALSE)
        }
        if (fx == 0) {
            return(x)
        }
    }

    stop("maximum number of iterations exceeded", call. = FALSE)
}
