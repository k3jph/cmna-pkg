## Copyright (c) 2016-2026, James P. Howard, II <jh@jameshoward.us>
## SPDX-License-Identifier: BSD-2-Clause

#' @title Cholesky decomposition
#'
#' @description
#' Decompose a symmetric positive-definite matrix into its Cholesky
#' factorization.
#'
#' @param m a square numeric matrix (must be symmetric positive-definite)
#'
#' @details
#' `choleskymatrix` decomposes the matrix `m` into the Cholesky
#' decomposition, such that \eqn{m = L^T \times L}.
#'
#' @return The upper-triangular matrix `L`.
#'
#' @family linear
#'
#' @examples
#' (A <- matrix(c(5, 1, 2, 1, 9, 3, 2, 3, 7), 3))
#' (L <- choleskymatrix(A))
#' t(L) %*% L
#'
#' @export
choleskymatrix <- function(m) {
    .cmna_validate_square_matrix(m, "m")

    count.rows <- nrow(m)
    count.cols <- ncol(m)

    L = diag(0, count.rows)
    for(i in 1:count.rows) {
        for(k in 1:i) {
            p.sum <- 0
            for(j in 1:k)
                p.sum <- p.sum + L[j, i] * L[j, k]
            if(i == k)
                L[k, i] <- sqrt(m[i, i] - p.sum)
            else
                L[k, i] <- (m[k, i] - p.sum) / L[k, k]
        }
    }
    return(L)
}
