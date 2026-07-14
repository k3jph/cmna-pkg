## Copyright (c) 2016-2026, James P. Howard, II <jh@jameshoward.us>
## SPDX-License-Identifier: BSD-2-Clause

#' @title Calculate the determinant of a matrix
#'
#' @description
#' Calculate the determinant of a square matrix.
#'
#' @param m a square numeric matrix
#'
#' @details
#' `detmatrix` calculates the determinant of the matrix given by
#' reducing it to row echelon form and taking the product of the
#' diagonal.
#'
#' @return A numeric scalar giving the determinant.
#'
#' @family linear
#'
#' @examples
#' A <- matrix(c(1, 2, -7, -1, -1, 1, 2, 1, 5), 3)
#' detmatrix(A)
#'
#' @export
detmatrix <- function(m) {
    .cmna_validate_square_matrix(m, "m")

    ref.m <- refmatrix(m)
    diagonal.m <- diag(ref.m)
    result <- prod(diagonal.m)
    return(result)
}
