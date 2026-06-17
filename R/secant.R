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
    .cmna_validate_function(f, "f")
    .cmna_validate_finite_scalar(x0, "x0")
    .cmna_validate_finite_scalar(x1, "x1")
    if (x0 == x1) {
        .cmna_abort(
            "x0 and x1 must be distinct",
            "cmna_invalid_argument",
            argument = c("x0", "x1"),
            x0 = x0,
            x1 = x1
        )
    }
    .cmna_validate_tolerance(tol)
    .cmna_validate_max_iterations(m)

    f0 <- .cmna_checked_value(f, x0, "f(x0)")
    if (f0 == 0) {
        return(x0)
    }

    f1 <- .cmna_checked_value(f, x1, "f(x1)")
    if (f1 == 0) {
        return(x1)
    }

    for (iter in seq_len(m)) {
        denominator <- .cmna_require_finite_scalar(
            f1 - f0,
            "secant denominator",
            method = "secant",
            iteration = iter - 1L,
            x0 = x0,
            x1 = x1,
            f0 = f0,
            f1 = f1
        )
        if (denominator == 0) {
            .cmna_abort(
                "secant denominator is zero",
                c("cmna_zero_denominator", "cmna_numerical_breakdown"),
                method = "secant",
                iteration = iter - 1L,
                x0 = x0,
                x1 = x1,
                f0 = f0,
                f1 = f1
            )
        }

        next_x <- .cmna_require_finite_scalar(
            x1 - f1 * (x1 - x0) / denominator,
            "next estimate",
            method = "secant",
            iteration = iter - 1L,
            x0 = x0,
            x1 = x1
        )

        if (next_x == x1) {
            .cmna_abort(
                paste(
                    "secant iteration can no longer advance",
                    "in floating-point arithmetic"
                ),
                c("cmna_stagnation", "cmna_convergence_failure"),
                method = "secant",
                iteration = iter - 1L,
                estimate = x1,
                function_value = f1
            )
        }

        step <- abs(next_x - x1)
        if (step <= tol) {
            return(next_x)
        }

        x0 <- x1
        f0 <- f1
        x1 <- next_x
        f1 <- .cmna_checked_value(f, x1, "f(x1)")
        if (f1 == 0) {
            return(x1)
        }
    }

    .cmna_abort(
        "maximum number of iterations exceeded",
        c("cmna_iteration_limit", "cmna_convergence_failure"),
        method = "secant",
        iterations = m,
        x0 = x0,
        x1 = x1,
        f0 = f0,
        f1 = f1
    )
}
