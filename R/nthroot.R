## Copyright (c) 2016-2026, James P. Howard, II <jh@jameshoward.us>
## SPDX-License-Identifier: BSD-2-Clause

#' @title Real n-th roots
#'
#' @description
#' Find the real `n`-th root of a finite scalar by Newton iteration.
#'
#' @param a A finite numeric scalar radicand.
#' @param n A positive whole number. Negative radicands require odd `n`.
#' @param tol A positive finite convergence tolerance.
#' @param m A positive whole-number iteration limit.
#'
#' @details
#' The iteration solves the positive magnitude using
#'
#' `x_next = ((n - 1) * x + abs(a) / x^(n - 1)) / n`
#'
#' and reapplies the sign for a negative radicand with odd `n`. Zero is returned
#' exactly. Convergence requires the residual to be no larger than `tol` times
#' the scale of the radicand. Stagnation, non-finite intermediate values, and
#' exhausted iteration limits are reported with CMNA condition classes.
#'
#' @return A numeric scalar containing the real `n`-th root.
#'
#' @family algebra
#'
#' @examples
#' nthroot(100, 2)
#' nthroot(65536, 4)
#' nthroot(-125, 3)
#'
#' @export
nthroot <- function(a, n, tol = 1 / 1000, m = 100) {
    .cmna_validate_finite_scalar(a, "a")
    .cmna_validate_tolerance(tol)
    .cmna_validate_max_iterations(m)

    if (!is.numeric(n) || length(n) != 1L || !is.finite(n) ||
        n < 1 || n != floor(n)) {
        .cmna_abort(
            "n must be a positive whole number",
            "cmna_invalid_argument",
            argument = "n",
            value = n
        )
    }

    if (a == 0) {
        return(0)
    }
    if (n == 1) {
        return(a)
    }
    if (a < 0 && n %% 2 == 0) {
        .cmna_abort(
            "negative radicands require an odd root degree",
            "cmna_domain_error",
            radicand = a,
            degree = n
        )
    }

    sign_result <- if (a < 0) -1 else 1
    target <- abs(a)
    x <- if (target >= 1) target / n else 1
    scale <- max(1, target)

    for (iteration in seq_len(m)) {
        denominator <- x^(n - 1)
        .cmna_require_finite_scalar(
            denominator,
            "nth-root denominator",
            iteration = iteration,
            estimate = x
        )
        if (denominator == 0) {
            .cmna_abort(
                "nth-root iteration encountered a zero denominator",
                c("cmna_zero_denominator", "cmna_numerical_breakdown"),
                iteration = iteration,
                estimate = x
            )
        }

        next_x <- ((n - 1) * x + target / denominator) / n
        .cmna_require_finite_scalar(
            next_x,
            "nth-root estimate",
            iteration = iteration
        )

        residual <- abs(next_x^n - target)
        .cmna_require_finite_scalar(
            residual,
            "nth-root residual",
            iteration = iteration,
            estimate = next_x
        )

        if (residual <= tol * scale) {
            return(sign_result * next_x)
        }
        if (next_x == x) {
            .cmna_abort(
                "nth-root iteration stagnated before convergence",
                c("cmna_stagnation", "cmna_convergence_failure"),
                iteration = iteration,
                estimate = x,
                residual = residual
            )
        }

        x <- next_x
    }

    .cmna_abort(
        "nth-root iteration exceeded the maximum iteration count",
        c("cmna_iteration_limit", "cmna_convergence_failure"),
        iterations = m,
        estimate = sign_result * x
    )
}
