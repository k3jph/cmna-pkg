## Copyright (c) 2016-2026, James P. Howard, II <jh@jameshoward.us>
## SPDX-License-Identifier: BSD-2-Clause

#' @rdname summation
#' @name summation
#'
#' @title Summation algorithms
#'
#' @description
#' Sum a numeric vector using naive, compensated, or pairwise summation.
#'
#' @param x A numeric vector. Empty vectors and `NULL` return zero.
#'
#' @details
#' `naivesum()` accumulates values from left to right. This is the most direct
#' summation algorithm, but it can lose low-order precision when many small
#' corrections are added to a large partial sum.
#'
#' `kahansum()` implements Kahan compensated summation. It keeps a compensation
#' term for low-order information lost to floating-point rounding and reinserts
#' that compensation during later additions.
#'
#' `pwisesum()` implements recursive pairwise summation. It divides the vector
#' into two parts, sums each part recursively, and adds the two partial sums.
#'
#' All three functions require numeric input. Non-finite values are allowed and
#' follow base-R arithmetic: `NA`, `NaN`, `Inf`, and `-Inf` propagate according
#' to ordinary R addition.
#'
#' @return A numeric scalar sum.
#'
#' @family intro
#'
#' @examples
#' x <- c(1, 1e-16, 1e-16, -1)
#' naivesum(x)
#' kahansum(x)
#' pwisesum(x)
#'
#' @export
naivesum <- function(x) {
    .cmna_validate_numeric_vector(x, "x")

    s <- 0
    n <- length(x)
    if (n == 0L) {
        return(s)
    }

    for (i in seq_len(n)) {
        s <- s + x[i]
    }

    s
}

#' @rdname summation
#' @export
kahansum <- function(x) {
    .cmna_validate_numeric_vector(x, "x")

    s <- 0
    comp <- 0
    n <- length(x)
    if (n == 0L) {
        return(s)
    }

    for (i in seq_len(n)) {
        y <- x[i] - comp
        t <- s + y
        comp <- (t - s) - y
        s <- t
    }

    s
}

#' @rdname summation
#' @export
pwisesum <- function(x) {
    .cmna_validate_numeric_vector(x, "x")

    n <- length(x)
    if (n == 0L) {
        return(0)
    }
    if (n == 1L) {
        return(x[[1L]])
    }

    m <- floor(n / 2)
    pwisesum(x[seq_len(m)]) + pwisesum(x[(m + 1L):n])
}
