## Copyright (c) 2016-2026, James P. Howard, II <jh@jameshoward.us>
## SPDX-License-Identifier: BSD-2-Clause

#' @title Gradient Descent
#'
#' @name gradient
#' @rdname gradient
#'
#' @description
#' Use gradient descent or ascent to find local extrema.
#'
#' @param fp function representing the derivative of the objective
#' @param x an initial estimate of the extremum (finite numeric scalar
#'   for `graddsc`/`gradasc`, numeric vector for `gd`)
#' @param h step size (positive numeric scalar)
#' @param tol error tolerance (positive numeric scalar)
#' @param m maximum number of iterations (positive integer)
#'
#' @details
#' Gradient descent can be used to find local minima of functions. It
#' will return an approximation based on the step size `h` and `fp`.
#' The `tol` is the error tolerance, `x` is the initial guess at the
#' minimum. This implementation also stops after `m` iterations.
#'
#' `graddsc` performs scalar gradient descent (minimization).
#' `gradasc` performs scalar gradient ascent (maximization).
#' `gd` performs multivariate gradient descent on a vector-valued
#' input.
#'
#' @return The `x` value of the extremum found.
#'
#' @family optimz
#'
#' @examples
#' fp <- function(x) { x^3 + 3 * x^2 - 1 }
#' graddsc(fp, 0)
#'
#' f <- function(x) { (x[1] - 1)^2 + (x[2] - 1)^2 }
#' fp <-function(x) {
#'     x1 <- 2 * x[1] - 2
#'     x2 <- 8 * x[2] - 8
#'
#'     return(c(x1, x2))
#' }
#' gd(fp, c(0, 0), 0.05)

#' @export
graddsc <- function(fp, x, h = 1e-3, tol = 1e-4, m = 1e3) {
    .cmna_validate_function(fp, "fp")
    .cmna_validate_finite_scalar(x, "x")
    .cmna_validate_positive_scalar(h, "h")
    .cmna_validate_tolerance(tol)
    .cmna_validate_max_iterations(m)

    iter <- 0

    oldx <- x
    x = x - h * fp(x)

    while(abs(x - oldx) > tol) {
        iter <- iter + 1
        if(iter > m)
            .cmna_abort(
                "maximum number of iterations exceeded",
                "cmna_convergence_failure",
                method = "graddsc",
                iterations = iter
            )
        oldx <- x
        x = x - h * fp(x)
    }

    return(x)
}

#' @rdname gradient
#' @export
gradasc <- function(fp, x, h = 1e-3, tol = 1e-4, m = 1e3) {
    .cmna_validate_function(fp, "fp")
    .cmna_validate_finite_scalar(x, "x")
    .cmna_validate_positive_scalar(h, "h")
    .cmna_validate_tolerance(tol)
    .cmna_validate_max_iterations(m)

    iter <- 0

    oldx <- x
    x = x + h * fp(x)

    while(abs(x - oldx) > tol) {
        iter <- iter + 1
        if(iter > m)
            .cmna_abort(
                "maximum number of iterations exceeded",
                "cmna_convergence_failure",
                method = "gradasc",
                iterations = iter
            )
        oldx <- x
        x = x + h * fp(x)
    }

    return(x)
}

#' @rdname gradient
#' @export
gd <- function(fp, x, h = 1e2, tol = 1e-4, m = 1e3) {
    .cmna_validate_function(fp, "fp")
    .cmna_validate_numeric_vector(x, "x")
    .cmna_validate_positive_scalar(h, "h")
    .cmna_validate_tolerance(tol)
    .cmna_validate_max_iterations(m)

    iter <- 0

    oldx <- x
    x = x - h * fp(x)

    while(vecnorm(x - oldx) > tol) {
        iter <- iter + 1
        if(iter > m)
            .cmna_abort(
                "maximum number of iterations exceeded",
                "cmna_convergence_failure",
                method = "gd",
                iterations = iter
            )
        oldx <- x
        x = x - h * fp(x)
    }

    return(x)
}
