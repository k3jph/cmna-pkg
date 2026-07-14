## Copyright (c) 2016-2026, James P. Howard, II <jh@jameshoward.us>
## SPDX-License-Identifier: BSD-2-Clause

#' @title Test for primality
#'
#' @description
#' Test whether a positive integer is prime by trial division.
#'
#' @param n a positive integer to test
#'
#' @details
#' `isPrime` tests `n` for primality by attempting division by every
#' integer from 2 up to `floor(sqrt(n))`. If any divisor produces a
#' zero remainder, the number is composite.
#'
#' This is the simplest correct primality test and is efficient only
#' for small values of `n`.
#'
#' @return `TRUE` if `n` is prime, `FALSE` otherwise.
#'
#' @family algebra
#'
#' @examples
#' isPrime(2)
#' isPrime(37)
#' isPrime(100)
#'
#' @export
isPrime <- function(n) {
    .cmna_validate_pos_integer(n, "n")

    if (n == 1) return(FALSE)
    if (n == 2) return(TRUE)
    if (n %% 2 == 0) return(FALSE)

    i <- 3
    while (i <= sqrt(n)) {
        if (n %% i == 0) return(FALSE)
        i <- i + 2
    }

    TRUE
}
