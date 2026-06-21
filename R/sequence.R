## Copyright (c) 2026, James P. Howard, II <jh@jameshoward.us>
## SPDX-License-Identifier: BSD-2-Clause

#' @title Deterministic numeric sequences
#'
#' @description
#' Construct a finite numeric sequence by repeated addition.
#'
#' @param from A finite numeric scalar giving the first value.
#' @param to A finite numeric scalar giving the limiting endpoint.
#' @param by A finite nonzero numeric scalar giving the increment.
#'
#' @details
#' `by` must point from `from` toward `to`. The endpoint is included when it is
#' reached, allowing for ordinary floating-point roundoff. When the increment
#' does not divide the interval evenly, the sequence stops before crossing the
#' endpoint. Equal endpoints return a one-element sequence for any nonzero
#' increment.
#'
#' @return A numeric vector containing the sequence.
#'
#' @family fundamentals
#'
#' @examples
#' cmna_sequence(1, 5, 1)
#' cmna_sequence(5, 1, -1)
#' cmna_sequence(0, 1, 0.1)
#'
#' @export
cmna_sequence <- function(from, to, by) {
    .cmna_validate_finite_scalar(from, "from")
    .cmna_validate_finite_scalar(to, "to")
    .cmna_validate_finite_scalar(by, "by")

    if (by == 0) {
        .cmna_abort(
            "by must be nonzero",
            "cmna_invalid_argument",
            argument = "by",
            value = by
        )
    }
    if ((from < to && by < 0) || (from > to && by > 0)) {
        .cmna_abort(
            "by points away from the endpoint",
            "cmna_invalid_argument",
            from = from,
            to = to,
            by = by
        )
    }
    if (from == to) {
        return(from)
    }

    tolerance <- 8 * .Machine$double.eps * max(1, abs(from), abs(to), abs(by))
    values <- numeric()
    value <- from

    within_endpoint <- if (by > 0) {
        function(x) x <= to + tolerance
    } else {
        function(x) x >= to - tolerance
    }

    while (within_endpoint(value)) {
        if (abs(value - to) <= tolerance) {
            value <- to
        }
        values <- c(values, value)
        value <- value + by
    }

    values
}
