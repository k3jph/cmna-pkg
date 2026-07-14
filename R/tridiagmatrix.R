## Copyright (c) 2016-2026, James P. Howard, II <jh@jameshoward.us>
## SPDX-License-Identifier: BSD-2-Clause

#' @title Solve a tridiagonal matrix
#'
#' @description
#' Use the tridiagonal matrix algorithm to solve a tridiagonal system.
#'
#' @param D numeric vector of entries on the main diagonal
#' @param L numeric vector of entries below the main diagonal
#' @param U numeric vector of entries above the main diagonal
#' @param b numeric vector of the right-hand side of the linear system
#'
#' @details
#' `tridiagmatrix` uses the tridiagonal matrix algorithm (Thomas
#' algorithm) to solve a tridiagonal linear system.
#'
#' @return The solution vector.
#'
#' @family linear
#'
#' @export
tridiagmatrix <- function(L, D, U, b) {
    .cmna_validate_numeric_vector(D, "D")
    .cmna_validate_numeric_vector(L, "L")
    .cmna_validate_numeric_vector(U, "U")
    .cmna_validate_numeric_vector(b, "b")

    n <- length(D)
    L <- c(NA, L)

    ##  The forward sweep
    U[1] <- U[1] / D[1]
    b[1] <- b[1] / D[1]
    for(i in 2:(n - 1)) {
        U[i] <- U[i] / (D[i] - L[i] * U[i - 1])
        b[i] <- (b[i] - L[i] * b[i - 1]) /
            (D[i] - L[i] * U[i - 1])
    }
    b[n] <- (b[n] - L[n] * b[n - 1]) /
        (D[n] - L[n] * U[n - 1])

    ##  The backward sweep
    x <- rep.int(0, n)
    x[n] <- b[n]
    for(i in (n - 1):1)
        x[i] <- b[i] - U[i] * x[i + 1]

    return(x)
}
