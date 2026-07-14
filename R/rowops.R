## Copyright (c) 2016-2026, James P. Howard, II <jh@jameshoward.us>
## SPDX-License-Identifier: BSD-2-Clause

#' @name rowops
#'
#' @title Elementary row operations
#'
#' @description
#' Elementary row operations for a matrix. These do not require a
#' square matrix and will work on any matrix. They use R's internal
#' row addressing to function.
#'
#' @param m a matrix
#' @param row a row index to modify
#' @param row1 a source row index
#' @param row2 a destination row index
#' @param k a numeric scaling factor
#'
#' @details
#' `replacerow` replaces one row with the sum of itself and the
#' multiple of another row. `swaprows` swaps two rows in the
#' matrix. `scalerow` scales all entries in a row by a constant.
#'
#' @return The modified matrix.
#'
#' @family linear
#'
#' @examples
#' n <- 5
#' A <- matrix(sample.int(10, n^2, TRUE) - 1, n)
#' A <- swaprows(A, 2, 4)
#' A <- replacerow(A, 1, 3, 2)
#' A <- scalerow(A, 5, 10)

#' @rdname rowops
#' @export
swaprows <- function(m, row1, row2) {
    .cmna_validate_matrix(m, "m")
    .cmna_validate_pos_integer(row1, "row1")
    .cmna_validate_pos_integer(row2, "row2")
    if (row1 > nrow(m))
        .cmna_abort("`row1` must not exceed the number of rows in `m`.",
                    "cmna_error_invalid_input")
    if (row2 > nrow(m))
        .cmna_abort("`row2` must not exceed the number of rows in `m`.",
                    "cmna_error_invalid_input")

    row.tmp <- m[row1,]
    m[row1,] <- m[row2,]
    m[row2,] <- row.tmp

    return(m)
}

#' @rdname rowops
#' @export
replacerow <- function(m, row1, row2, k) {
    .cmna_validate_matrix(m, "m")
    .cmna_validate_pos_integer(row1, "row1")
    .cmna_validate_pos_integer(row2, "row2")
    if (row1 > nrow(m))
        .cmna_abort("`row1` must not exceed the number of rows in `m`.",
                    "cmna_error_invalid_input")
    if (row2 > nrow(m))
        .cmna_abort("`row2` must not exceed the number of rows in `m`.",
                    "cmna_error_invalid_input")

    m[row2,] <- m[row2,] + m[row1,] * k
    return(m)
}

#' @rdname rowops
#' @export
scalerow <- function(m, row, k) {
    .cmna_validate_matrix(m, "m")
    .cmna_validate_pos_integer(row, "row")
    if (row > nrow(m))
        .cmna_abort("`row` must not exceed the number of rows in `m`.",
                    "cmna_error_invalid_input")

    m[row,] <- m[row,] * k
    return(m)
}
