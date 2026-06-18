## Copyright (c) 2016-2026, James P. Howard, II <jh@jameshoward.us>
## SPDX-License-Identifier: BSD-2-Clause

.cmna_validate_quadratic_coefficients <- function(b2, b1, b0) {
    values <- list(b2 = b2, b1 = b1, b0 = b0)
    for (name in names(values)) {
        value <- values[[name]]
        if (!is.numeric(value) || length(value) != 1L || !is.finite(value)) {
            .cmna_abort(
                sprintf("%s must be a finite numeric scalar", name),
                "cmna_invalid_argument",
                argument = name,
                value = value
            )
        }
    }

    if (b2 == 0) {
        .cmna_abort(
            "b2 must be nonzero for a quadratic equation",
            "cmna_invalid_argument",
            argument = "b2",
            value = b2
        )
    }

    discriminant <- b1^2 - 4 * b2 * b0
    if (discriminant < 0) {
        .cmna_abort(
            "quadratic equation has no real roots",
            "cmna_domain_error",
            discriminant = discriminant,
            coefficients = c(b2, b1, b0)
        )
    }

    discriminant
}

#' @rdname quadratic
#' @name quadratic
#'
#' @title Real roots of a quadratic equation
#'
#' @description
#' Find the real roots of `b2*x^2 + b1*x + b0 = 0`.
#'
#' @param b2 The finite nonzero coefficient of the `x^2` term.
#' @param b1 The finite coefficient of the `x` term.
#' @param b0 The finite constant term.
#'
#' @details
#' `quadratic()` implements the familiar textbook formula directly.
#' `quadratic2()` uses a cancellation-resistant formulation and computes the
#' second root from the product-of-roots identity when possible.
#'
#' Both functions return roots in ascending numeric order. A repeated root is
#' returned twice. Equations with a negative discriminant are outside this
#' real-root contract and signal a `cmna_domain_error` condition.
#'
#' @return A numeric vector of length two containing the real roots in ascending
#'   order.
#'
#' @family algebra
#'
#' @examples
#' quadratic(1, 0, -1)
#' quadratic2(1, 0, -1)
#' quadratic2(1, -1e8, 1)
#'
#' @export
quadratic <- function(b2, b1, b0) {
    discriminant <- .cmna_validate_quadratic_coefficients(b2, b1, b0)
    root_discriminant <- sqrt(discriminant)
    denominator <- 2 * b2

    sort(c(
        (-b1 - root_discriminant) / denominator,
        (-b1 + root_discriminant) / denominator
    ))
}

#' @rdname quadratic
#' @export
quadratic2 <- function(b2, b1, b0) {
    discriminant <- .cmna_validate_quadratic_coefficients(b2, b1, b0)
    root_discriminant <- sqrt(discriminant)

    if (root_discriminant == 0) {
        root <- -b1 / (2 * b2)
        return(c(root, root))
    }

    sign_b1 <- if (b1 < 0) -1 else 1
    q <- -0.5 * (b1 + sign_b1 * root_discriminant)

    root1 <- q / b2
    root2 <- if (q == 0) {
        -b1 / b2
    } else {
        b0 / q
    }

    sort(c(root1, root2))
}
