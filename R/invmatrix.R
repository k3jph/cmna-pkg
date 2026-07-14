## Copyright (c) 2016-2026, James P. Howard, II <jh@jameshoward.us>
## SPDX-License-Identifier: BSD-2-Clause

#' @title Invert a matrix
#'
#' @description
#' Invert a matrix using Gaussian elimination.
#'
#' @param m a square numeric matrix
#'
#' @details
#' `invmatrix` inverts the given matrix using Gaussian elimination
#' and returns the result.
#'
#' @return The inverted matrix.
#'
#' @family linear
#'
#' @examples
#' A <- matrix(c(1, 2, -7, -1, -1, 1, 2, 1, 5), 3)
#' invmatrix(A)
#'
#' @export
invmatrix <- function(m) {
    .cmna_validate_square_matrix(m, "m")

    count.rows <- nrow(m)
    count.cols <- ncol(m)

    I = diag(count.cols)
    tmp <- cbind(m, I)
    tmp <- rrefmatrix(tmp)
    res <- tmp[, (count.cols + 1):(count.cols * 2)]
    return(res)
}
