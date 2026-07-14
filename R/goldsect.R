## Copyright (c) 2016-2026, James P. Howard, II <jh@jameshoward.us>
## SPDX-License-Identifier: BSD-2-Clause

#' @title Golden Section Search
#'
#' @name goldsect
#' @rdname goldsect
#'
#' @description
#' Use golden section search to find local extrema.
#'
#' @param f function to optimize
#' @param a lower bound of the search region (finite numeric scalar)
#' @param b upper bound of the search region (finite numeric scalar)
#' @param tol error tolerance (positive numeric scalar, default 1e-3)
#' @param m maximum number of iterations (positive integer, default 100)
#'
#' @details
#' The golden section search method functions by repeatedly dividing
#' the interval between `a` and `b` using the golden ratio and will
#' return when the interval between them is less than `tol`, the error
#' tolerance. However, this implementation also stops if after `m`
#' iterations.
#'
#' `goldsectmin` searches for a local minimum; `goldsectmax` searches
#' for a local maximum.
#'
#' @return The `x` value of the extremum found.
#'
#' @family optimz
#'
#' @examples
#' f <- function(x) { x^2 - 3 * x + 3 }
#' goldsectmin(f, 0, 5)
#'
#' @export
goldsectmin <- function(f, a, b, tol = 1e-3, m = 100) {
    .cmna_validate_function(f, "f")
    .cmna_validate_finite_scalar(a, "a")
    .cmna_validate_finite_scalar(b, "b")
    .cmna_validate_tolerance(tol)
    .cmna_validate_max_iterations(m)

    iter <- 0
    phi <- (sqrt(5) - 1) / 2

    a.star <- b - phi * abs(b - a)
    b.star <- a + phi * abs(b - a)

    while (abs(b - a) > tol) {
        iter <- iter + 1
        if (iter > m) {
            .cmna_abort(
                "maximum number of iterations exceeded",
                c("cmna_iteration_limit", "cmna_convergence_failure"),
                method = "goldsectmin",
                iterations = iter,
                a = a,
                b = b
            )
        }

        if(f(a.star) < f(b.star)) {
            b <- b.star
            b.star <- a.star
            a.star <- b - phi * abs(b - a)
        } else {
            a <- a.star
            a.star <- b.star
            b.star <- a + phi * abs(b - a)
        }
    }

    return((a + b) / 2)
}

#' @rdname goldsect
#' @export
goldsectmax <- function(f, a, b, tol = 1e-3, m = 100) {
    .cmna_validate_function(f, "f")
    .cmna_validate_finite_scalar(a, "a")
    .cmna_validate_finite_scalar(b, "b")
    .cmna_validate_tolerance(tol)
    .cmna_validate_max_iterations(m)

    iter <- 0
    phi <- (sqrt(5) - 1) / 2

    a.star <- b - phi * abs(b - a)
    b.star <- a + phi * abs(b - a)

    while (abs(b - a) > tol) {
        iter <- iter + 1
        if (iter > m) {
            .cmna_abort(
                "maximum number of iterations exceeded",
                c("cmna_iteration_limit", "cmna_convergence_failure"),
                method = "goldsectmax",
                iterations = iter,
                a = a,
                b = b
            )
        }

        if(f(a.star) > f(b.star)) {
            b <- b.star
            b.star <- a.star
            a.star <- b - phi * abs(b - a)
        } else {
            a <- a.star
            a.star <- b.star
            b.star <- a + phi * abs(b - a)
        }
    }

    return((a + b) / 2)
}
