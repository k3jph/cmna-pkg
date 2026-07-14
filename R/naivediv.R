## Copyright (c) 2016-2026, James P. Howard, II <jh@jameshoward.us>
## SPDX-License-Identifier: BSD-2-Clause

#' @name division
#' @rdname division
#'
#' @title Integer division algorithms
#'
#' @description
#' Compute the quotient and remainder of integer division using
#' elementary algorithms.
#'
#' @param m the dividend (a nonnegative integer)
#' @param n the divisor (a positive integer)
#'
#' @details
#' `naivediv` divides `m` by `n` using repeated subtraction.
#' `longdiv` uses the binary long-division algorithm, processing
#' bits from most significant to least significant.
#'
#' Both functions return the unique quotient `q` and remainder `r`
#' satisfying `m = q * n + r` with `0 <= r < n`.
#'
#' @return A list with components `quotient` and `remainder`.
#'
#' @family algebra
#'
#' @examples
#' naivediv(17, 5)
#' longdiv(17, 5)
#'
#' @export
naivediv <- function(m, n) {
    .cmna_validate_nonneg_integer(m, "m")
    .cmna_validate_pos_integer(n, "n")

    quot <- 0
    r <- m

    while (r >= n) {
        quot <- quot + 1
        r <- r - n
    }

    list(quotient = quot, remainder = r)
}

#' @rdname division
#' @export
longdiv <- function(m, n) {
    .cmna_validate_nonneg_integer(m, "m")
    .cmna_validate_pos_integer(n, "n")

    quot <- 0
    r <- 0

    for (i in 31:0) {
        r <- bitwShiftL(r, 1)
        r <- r + bitwAnd(bitwShiftR(m, i), 1)
        if (r >= n) {
            r <- r - n
            quot <- quot + bitwShiftL(1, i)
        }
    }

    list(quotient = quot, remainder = r)
}
