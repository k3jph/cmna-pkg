## Copyright (c) 2016-2026, James P. Howard, II <jh@jameshoward.us>
## SPDX-License-Identifier: BSD-2-Clause

#' @title Exact Fibonacci numbers
#'
#' @description
#' Return the `n`-th Fibonacci number using iterative addition.
#'
#' @param n A whole-number index between 0 and 78 inclusive.
#'
#' @details
#' The sequence is indexed by `F(0) = 0`, `F(1) = 1`, and
#' `F(n) = F(n - 1) + F(n - 2)`.
#'
#' The implementation is iterative and runs in linear time with constant
#' auxiliary storage. R numeric values can represent every integer through
#' `F(78)` exactly; larger indices are rejected rather than returned with silent
#' integer-rounding error.
#'
#' @return A numeric scalar containing the exact Fibonacci number.
#'
#' @family algebra
#'
#' @examples
#' fibonacci(0)
#' fibonacci(10)
#' fibonacci(78)
#'
#' @export
fibonacci <- function(n) {
    if (!is.numeric(n) || length(n) != 1L || !is.finite(n) ||
        n < 0 || n != floor(n)) {
        .cmna_abort(
            "n must be a nonnegative whole number",
            "cmna_invalid_argument",
            argument = "n",
            value = n
        )
    }
    if (n > 78) {
        .cmna_abort(
            "n must not exceed 78 for exact numeric results",
            "cmna_domain_error",
            argument = "n",
            value = n
        )
    }
    if (n == 0) {
        return(0)
    }

    previous <- 0
    current <- 1
    for (index in seq_len(n - 1L)) {
        next_value <- previous + current
        previous <- current
        current <- next_value
    }

    current
}
