## Copyright (c) 2016-2026, James P. Howard, II <jh@jameshoward.us>
## SPDX-License-Identifier: BSD-2-Clause

#' @name gdls
#'
#' @title Least squares with gradient descent
#'
#' @description
#' Solve least squares with gradient descent.
#'
#' @param A a matrix representing the design matrix of a linear system
#' @param b a numeric vector representing the response
#' @param alpha the learning rate (positive numeric scalar)
#' @param tol the convergence tolerance (positive numeric scalar)
#' @param m the maximum number of iterations (positive integer)
#'
#' @details
#' `gdls` solves a linear system using gradient descent to minimize
#' the sum of squared residuals.
#'
#' @return The coefficient vector.
#'
#' @family linear
#'
#' @examples
#' head(b <- iris$Sepal.Length)
#' head(A <- matrix(cbind(1, iris$Sepal.Width, iris$Petal.Length, iris$Petal.Width), ncol = 4))
#' gdls(A, b, alpha = 0.05, m = 10000)
#'
#' @export
gdls <- function(A, b, alpha = 0.05, tol = 1e-6, m = 1e5) {
    .cmna_validate_matrix(A, "A")
    .cmna_validate_numeric_vector(b, "b")
    .cmna_validate_positive_scalar(alpha, "alpha")
    .cmna_validate_tolerance(tol)
    .cmna_validate_pos_integer(m, "m")

    iter <- 0
    n <- ncol(A)
    theta <- matrix(rep(0, n))
    oldtheta = theta + 10 * tol

    while(vecnorm(oldtheta - theta) > tol) {
        if((iter <- iter + 1) > m) {
            warning("iterations maximum exceeded")
            return(theta)
        }
        e <- (A %*% theta - b)
        d <- (t(A) %*% e) / length(b)
        oldtheta <- theta
        theta <- theta - alpha * d
    }

    return(theta)
}
