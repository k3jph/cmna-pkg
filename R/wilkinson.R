## Copyright (c) 2016-2026, James P. Howard, II <jh@jameshoward.us>
## SPDX-License-Identifier: BSD-2-Clause

#' @title Wilkinson's polynomial
#'
#' @description
#' Evaluate Wilkinson's polynomial at a given point.
#'
#' @param x the evaluation point (numeric scalar or vector)
#' @param w the number of terms in the polynomial (a positive integer,
#'   default 20)
#'
#' @details
#' Wilkinson's polynomial is the product `(x - 1)(x - 2) ... (x - w)`,
#' giving a polynomial with real roots at each integer from 1 to `w`.
#' The default `w = 20` is the classical form. This polynomial is a
#' standard example of ill-conditioning in root finding.
#'
#' The function is computed recursively: `wilkinson(x, 1) = x - 1`
#' and `wilkinson(x, w) = (x - w) * wilkinson(x, w - 1)`.
#'
#' @return The value of the polynomial at `x`.
#'
#' @family polynomials
#'
#' @examples
#' wilkinson(0)
#' wilkinson(1:20)
#'
#' @export
wilkinson <- function(x, w = 20) {
    .cmna_validate_pos_integer(w, "w")

    if (w == 1) return(x - 1)
    (x - w) * wilkinson(x, w - 1)
}
