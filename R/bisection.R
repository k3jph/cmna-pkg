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

#' @title The Bisection Method
#'
#' @description
#' Locate a real root of a continuous function by repeatedly halving an
#' interval that brackets the root.
#'
#' @param f A function of one numeric argument.
#' @param a,b Finite numeric endpoints of the initial interval. If supplied in
#'   reverse order, they are reordered silently.
#' @param tol A positive finite numeric tolerance for the interval width.
#' @param m A positive whole number giving the maximum number of iterations.
#'
#' @details
#' The method requires the initial interval to bracket a root: either an
#' endpoint is itself a root, or the function values at the endpoints have
#' opposite signs. At each iteration, the interval is replaced by the half
#' that continues to bracket a root.
#'
#' Iteration stops when the interval width is no greater than \code{tol}. The
#' returned value is the midpoint of the final interval. If floating-point
#' arithmetic can no longer produce a midpoint distinct from both endpoints,
#' the function stops with an error.
#'
#' @return A numeric approximation to a real root of \code{f}.
#'
#' @family optimization
#'
#' @examples
#' f <- function(x) x^3 - 2 * x^2 - 159 * x - 540
#' bisection(f, 10, 20)
#'
#' g <- function(x) x - 2
#' bisection(g, 5, 2)
#'
#' @export
bisection <- function(f, a, b, tol = 1e-3, m = 100) {
    if (!is.function(f)) {
        stop("f must be a function", call. = FALSE)
    }
    if (!is.numeric(a) || length(a) != 1L || !is.finite(a)) {
        stop("a must be a finite numeric scalar", call. = FALSE)
    }
    if (!is.numeric(b) || length(b) != 1L || !is.finite(b)) {
        stop("b must be a finite numeric scalar", call. = FALSE)
    }
    if (!is.numeric(tol) || length(tol) != 1L || !is.finite(tol) || tol <= 0) {
        stop("tol must be a positive finite numeric scalar", call. = FALSE)
    }
    if (!is.numeric(m) || length(m) != 1L || !is.finite(m) || m < 1 || m != floor(m)) {
        stop("m must be a positive whole number", call. = FALSE)
    }

    if (a > b) {
        tmp <- a
        a <- b
        b <- tmp
    }

    f.a <- f(a)
    f.b <- f(b)

    if (!is.numeric(f.a) || length(f.a) != 1L || !is.finite(f.a)) {
        stop("f(a) must be a finite numeric scalar", call. = FALSE)
    }
    if (!is.numeric(f.b) || length(f.b) != 1L || !is.finite(f.b)) {
        stop("f(b) must be a finite numeric scalar", call. = FALSE)
    }

    if (f.a == 0) {
        return(a)
    }
    if (f.b == 0) {
        return(b)
    }
    if (sign(f.a) == sign(f.b)) {
        stop("the initial interval does not bracket a root", call. = FALSE)
    }

    iter <- 0L

    while (abs(b - a) > tol) {
        if (iter >= m) {
            stop("maximum number of iterations exceeded", call. = FALSE)
        }
        iter <- iter + 1L

        xmid <- a + (b - a) / 2
        if (xmid == a || xmid == b) {
            stop("bisection interval can no longer be reduced in floating-point arithmetic",
                 call. = FALSE)
        }

        ymid <- f(xmid)
        if (!is.numeric(ymid) || length(ymid) != 1L || !is.finite(ymid)) {
            stop("f(midpoint) must be a finite numeric scalar", call. = FALSE)
        }
        if (ymid == 0) {
            return(xmid)
        }

        if (sign(f.a) != sign(ymid)) {
            b <- xmid
            f.b <- ymid
        } else {
            a <- xmid
            f.a <- ymid
        }
    }

    a + (b - a) / 2
}
