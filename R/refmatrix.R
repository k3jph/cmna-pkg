## Copyright (c) 2016-2026, James P. Howard, II <jh@jameshoward.us>
## SPDX-License-Identifier: BSD-2-Clause

#' @name refmatrix
#' @rdname refmatrix
#'
#' @title Matrix to row echelon form
#'
#' @description
#' Transform a matrix to row echelon form.
#'
#' @param m a matrix
#' @param A a matrix representing the coefficients of a linear
#'   system in `solvematrix`
#' @param b a numeric vector representing the right-hand side of the
#'   linear system in `solvematrix`
#'
#' @details
#' `refmatrix` reduces a matrix to row echelon form. This is not a
#' reduced row echelon form, though that can be easily calculated from
#' the diagonal. This function works on non-square matrices.
#'
#' `rrefmatrix` returns the reduced row echelon matrix.
#'
#' `solvematrix` solves a linear system using `rrefmatrix`.
#'
#' @return The modified matrix, or for `solvematrix` the solution vector.
#'
#' @family linear
#'
#' @examples
#' A <- matrix(c(1, 2, -7, -1, -1, 1, 2, 1, 5), 3)
#' refmatrix(A)
#'
#' @export
refmatrix <- function(m) {
    .cmna_validate_matrix(m, "m")

    count.rows <- nrow(m)
    count.cols <- ncol(m)
    piv <- 1

    for(row.curr in 1:count.rows) {
        if(piv <= count.cols) {
            i <- row.curr
            while(m[i, piv] == 0 && i < count.rows) {
                i <- i + 1
                if(i > count.rows) {
                    i <- row.curr
                    piv <- piv + 1
                    if(piv > count.cols)
                        return(m)
                }
            }
            if(i != row.curr)
                m <- swaprows(m, i, row.curr)
            for(j in row.curr:count.rows)
                if(j != row.curr) {
                    k <- m[j, piv] / m[row.curr, piv]
                    m <- replacerow(m, row.curr, j, -k)
                }
            piv <- piv + 1
        }
    }
    return(m)
}

#' @rdname refmatrix
#' @export
rrefmatrix <- function(m) {
    .cmna_validate_matrix(m, "m")

    count.rows <- nrow(m)
    count.cols <- ncol(m)
    piv <- 1

    for(row.curr in 1:count.rows) {
        if(piv <= count.cols) {
            i <- row.curr
            while(m[i, piv] == 0 && i < count.rows) {
                i <- i + 1
                if(i > count.rows) {
                    i <- row.curr
                    piv <- piv + 1
                    if(piv > count.cols)
                        return(m)
                }
            }
            if(i != row.curr)
                m <- swaprows(m, i, row.curr)
            piv.val <- m[row.curr, piv]
            m <- scalerow(m, row.curr, 1 / piv.val)
            for(j in 1:count.rows)
                if(j != row.curr) {
                    k <- m[j, piv] / m[row.curr, piv]
                    m <- replacerow(m, row.curr, j, -k)
                }
            piv <- piv + 1
        }
    }
    return(m)
}

#' @rdname refmatrix
#' @export
solvematrix <- function(A, b) {
    .cmna_validate_matrix(A, "A")
    .cmna_validate_numeric_vector(b, "b")

    m <- cbind(A, b)
    m <- rrefmatrix(m)
    x <- m[, ncol(m)]

    return(x)
}
