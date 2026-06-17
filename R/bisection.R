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
    .cmna_validate_function(f, "f")
    .cmna_validate_finite_scalar(a, "a")
    .cmna_validate_finite_scalar(b, "b")
    .cmna_validate_tolerance(tol)
    .cmna_validate_max_iterations(m)

    if (a > b) {
        tmp <- a
        a <- b
        b <- tmp
    }

    f.a <- .cmna_checked_value(f, a, "f(a)")
    f.b <- .cmna_checked_value(f, b, "f(b)")

    if (f.a == 0) {
        return(a)
    }
    if (f.b == 0) {
        return(b)
    }
    if (sign(f.a) == sign(f.b)) {
        .cmna_abort(
            "the initial interval does not bracket a root",
            c("cmna_invalid_bracket", "cmna_invalid_argument"),
            method = "bisection",
            a = a,
            b = b,
            f_a = f.a,
            f_b = f.b
        )
    }

    iter <- 0L

    while (abs(b - a) > tol) {
        if (iter >= m) {
            .cmna_abort(
                "maximum number of iterations exceeded",
                c("cmna_iteration_limit", "cmna_convergence_failure"),
                method = "bisection",
                iterations = iter,
                a = a,
                b = b
            )
        }
        iter <- iter + 1L

        xmid <- a + (b - a) / 2
        if (xmid == a || xmid == b) {
            .cmna_abort(
                paste(
                    "bisection interval can no longer be reduced",
                    "in floating-point arithmetic"
                ),
                c("cmna_stagnation", "cmna_convergence_failure"),
                method = "bisection",
                iteration = iter,
                a = a,
                b = b,
                midpoint = xmid
            )
        }

        ymid <- .cmna_checked_value(f, xmid, "f(midpoint)")
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
