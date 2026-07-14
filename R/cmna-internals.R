## Copyright (c) 2016-2026, James P. Howard, II <jh@jameshoward.us>
## SPDX-License-Identifier: BSD-2-Clause

.cmna_abort <- function(message, classes, ...) {
    condition <- structure(
        c(
            list(message = message, call = NULL),
            list(...)
        ),
        class = unique(c(classes, "cmna_error", "error", "condition"))
    )

    stop(condition)
}

.cmna_validate_function <- function(value, name) {
    if (!is.function(value)) {
        .cmna_abort(
            sprintf("%s must be a function", name),
            "cmna_invalid_argument",
            argument = name
        )
    }

    invisible(value)
}

.cmna_validate_numeric_vector <- function(value, name) {
    if (is.null(value)) {
        return(invisible(value))
    }
    if (!is.numeric(value)) {
        .cmna_abort(
            sprintf("%s must be a numeric vector", name),
            "cmna_invalid_argument",
            argument = name,
            value = value
        )
    }

    invisible(value)
}

.cmna_validate_finite_scalar <- function(value, name) {
    if (!is.numeric(value) || length(value) != 1L || !is.finite(value)) {
        .cmna_abort(
            sprintf("%s must be a finite numeric scalar", name),
            "cmna_invalid_argument",
            argument = name,
            value = value
        )
    }

    invisible(value)
}

.cmna_validate_tolerance <- function(value) {
    if (!is.numeric(value) || length(value) != 1L ||
        !is.finite(value) || value <= 0) {
        .cmna_abort(
            "tol must be a positive finite numeric scalar",
            "cmna_invalid_argument",
            argument = "tol",
            value = value
        )
    }

    invisible(value)
}

.cmna_validate_max_iterations <- function(value) {
    if (!is.numeric(value) || length(value) != 1L ||
        !is.finite(value) || value < 1 || value != floor(value)) {
        .cmna_abort(
            "m must be a positive whole number",
            "cmna_invalid_argument",
            argument = "m",
            value = value
        )
    }

    invisible(value)
}

.cmna_require_finite_scalar <- function(value, label, ...) {
    if (!is.numeric(value) || length(value) != 1L || !is.finite(value)) {
        .cmna_abort(
            sprintf("%s must be a finite numeric scalar", label),
            c("cmna_non_finite_value", "cmna_numerical_breakdown"),
            label = label,
            value = value,
            ...
        )
    }

    value
}

.cmna_checked_value <- function(f, x, label) {
    .cmna_require_finite_scalar(
        f(x),
        label,
        argument = x
    )
}

.cmna_validate_pos_integer <- function(value, name) {
    if (!is.numeric(value) || length(value) != 1L ||
        !is.finite(value) || value < 1 || value != floor(value)) {
        .cmna_abort(
            sprintf("%s must be a positive whole number", name),
            "cmna_invalid_argument",
            argument = name,
            value = value
        )
    }

    invisible(value)
}

.cmna_validate_nonneg_integer <- function(value, name) {
    if (!is.numeric(value) || length(value) != 1L ||
        !is.finite(value) || value < 0 || value != floor(value)) {
        .cmna_abort(
            sprintf("%s must be a nonnegative whole number", name),
            "cmna_invalid_argument",
            argument = name,
            value = value
        )
    }

    invisible(value)
}

.cmna_validate_square_matrix <- function(value, name) {
    if (!is.matrix(value)) {
        .cmna_abort(
            sprintf("%s must be a matrix", name),
            "cmna_invalid_argument",
            argument = name
        )
    }
    if (nrow(value) != ncol(value)) {
        .cmna_abort(
            sprintf("%s must be a square matrix", name),
            "cmna_invalid_argument",
            argument = name
        )
    }

    invisible(value)
}

.cmna_validate_matrix <- function(value, name) {
    if (!is.matrix(value)) {
        .cmna_abort(
            sprintf("%s must be a matrix", name),
            "cmna_invalid_argument",
            argument = name
        )
    }

    invisible(value)
}

.cmna_validate_positive_scalar <- function(value, name) {
    if (!is.numeric(value) || length(value) != 1L ||
        !is.finite(value) || value <= 0) {
        .cmna_abort(
            sprintf("%s must be a positive finite numeric scalar", name),
            "cmna_invalid_argument",
            argument = name,
            value = value
        )
    }

    invisible(value)
}
