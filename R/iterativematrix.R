## Copyright (c) 2016-2026, James P. Howard, II <jh@jameshoward.us>
## SPDX-License-Identifier: BSD-2-Clause

#' @rdname iterativematrix
#' @name iterativematrix
#'
#' @title Solve a matrix using iterative methods
#'
#' @description
#' Solve a linear system using iterative methods.
#'
#' @param A a square numeric matrix representing the coefficients of a
#'   linear system
#' @param b a numeric vector representing the right-hand side of the
#'   linear system
#' @param tol a numeric tolerance for convergence
#' @param maxiter the maximum number of iterations
#'
#' @details
#' `jacobi` finds the solution using Jacobi iteration.
#' Jacobi iteration depends on the matrix being diagonally dominant.
#' The tolerance is measured by the norm of the solution vector.
#'
#' `gaussseidel` finds the solution using Gauss-Seidel iteration.
#' Gauss-Seidel iteration depends on the matrix being either
#' diagonally dominant or symmetric and positive definite.
#'
#' `cgmmatrix` finds the solution using the conjugate gradient
#' method. The conjugate gradient method depends on the matrix being
#' symmetric and positive definite.
#'
#' @return The solution vector.
#'
#' @family linear
#'
#' @examples
#' A <- matrix(c(5, 2, 1, 2, 7, 3, 3, 4, 8), 3)
#' b <- c(40, 39, 55)
#' jacobi(A, b)
#'
#' @export
jacobi <- function(A, b, tol = 10e-7, maxiter = 100) {
    .cmna_validate_square_matrix(A, "A")
    .cmna_validate_numeric_vector(b, "b")
    .cmna_validate_tolerance(tol)
    .cmna_validate_pos_integer(maxiter, "maxiter")

    n <- length(b)
    iter <- 0

    Dinv <- diag(1 / diag(A))
    R <- A - diag(diag(A))
    x <- rep(0, n)
    newx <- rep(tol, n)

    while(vecnorm(newx - x) > tol) {
        if(maxiter < iter) {
            warning("iterations maximum exceeded")
            break
        }
        x <- newx
        newx <- Dinv %*% (b - R %*% x)
        iter <- iter + 1
    }

    return(as.vector(newx))
}

#' @rdname iterativematrix
#' @export
gaussseidel <- function(A, b, tol = 10e-7, maxiter = 100) {
    .cmna_validate_square_matrix(A, "A")
    .cmna_validate_numeric_vector(b, "b")
    .cmna_validate_tolerance(tol)
    .cmna_validate_pos_integer(maxiter, "maxiter")

    n <- length(b)
    iter <- 0

    L <- U <- A
    L[upper.tri(A, diag = FALSE)] <- 0
    U[lower.tri(A, diag = TRUE)] <- 0
    Linv <- solve(L)

    x <- rep(0, n)
    newx <- rep(tol * 10, n)

    while(vecnorm(newx - x) > tol) {
        if(maxiter < iter) {
            warning("iterations maximum exceeded")
            break
        }
        x <- newx
        newx <- Linv %*% (b - U %*% x)
        iter <- iter + 1
    }

    return(as.vector(newx))
}

#' @rdname iterativematrix
#' @export
cgmmatrix <- function(A, b, tol = 10e-7, maxiter = 100) {
    .cmna_validate_square_matrix(A, "A")
    .cmna_validate_numeric_vector(b, "b")
    .cmna_validate_tolerance(tol)
    .cmna_validate_pos_integer(maxiter, "maxiter")

    n <- length(b)
    iter <- 0

    x <- rep(0, n)
    newx <- rep(tol * 10, n)

    p <- r <- b - A %*% x
    while(vecnorm(r) > tol) {
        if(maxiter < iter) {
            warning("iterations maximum exceeded")
            break
        }
		a <- as.numeric((t(r) %*% r) / t(p) %*% A %*% p)
        newx <- x + a * p
        newr <- r - a * A %*% p
        beta <- as.numeric(t(newr) %*% newr / (t(r) %*% r))
        p <- newr + beta * p
        r <- newr
        x <- newx
        iter <- iter + 1
    }

    return(as.vector(x))
}
