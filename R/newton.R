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
    .cmna_validate_function(f, "f")
    .cmna_validate_function(fp, "fp")
    .cmna_validate_finite_scalar(x, "x")
    .cmna_validate_tolerance(tol)
    .cmna_validate_max_iterations(m)

    fx <- .cmna_checked_value(f, x, "f(x)")
    if (fx == 0) {
        return(x)
    }

    for (iter in seq_len(m)) {
        fpx <- .cmna_checked_value(fp, x, "fp(x)")
        if (fpx == 0) {
            .cmna_abort(
                "derivative is zero at the current estimate",
                c("cmna_zero_derivative", "cmna_numerical_breakdown"),
                method = "newton",
                iteration = iter - 1L,
                estimate = x,
                function_value = fx
            )
        }

        next_x <- .cmna_require_finite_scalar(
            x - fx / fpx,
            "next estimate",
            method = "newton",
            iteration = iter - 1L,
            estimate = x
        )

        if (next_x == x) {
            .cmna_abort(
                paste(
                    "Newton iteration can no longer advance",
                    "in floating-point arithmetic"
                ),
                c("cmna_stagnation", "cmna_convergence_failure"),
                method = "newton",
                iteration = iter - 1L,
                estimate = x,
                function_value = fx
            )
        }

        step <- abs(next_x - x)
        if (step <= tol) {
            return(next_x)
        }

        x <- next_x
        fx <- .cmna_checked_value(f, x, "f(x)")
        if (fx == 0) {
            return(x)
        }
    }

    .cmna_abort(
        "maximum number of iterations exceeded",
        c("cmna_iteration_limit", "cmna_convergence_failure"),
        method = "newton",
        iterations = m,
        estimate = x,
        function_value = fx
    )
}
