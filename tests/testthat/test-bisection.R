test_that("bisection finds a known root", {
    f <- function(x) x^2 - 2
    root <- bisection(f, 1, 2, tol = 1e-10)

    expect_equal(root, sqrt(2), tolerance = 1e-10)
})

test_that("bisection quietly reorders reversed endpoints", {
    f <- function(x) x^2 - 2

    expect_equal(
        bisection(f, 2, 1, tol = 1e-10),
        bisection(f, 1, 2, tol = 1e-10)
    )
})

test_that("bisection returns an endpoint that is already a root", {
    f <- function(x) x - 2

    expect_identical(bisection(f, 2, 5), 2)
    expect_identical(bisection(f, 0, 2), 2)
})

test_that("bisection rejects an interval that does not bracket a root", {
    f <- function(x) x^2 + 1

    expect_error(
        bisection(f, -1, 1),
        "initial interval does not bracket a root",
        class = "cmna_invalid_bracket"
    )
    expect_error(
        bisection(f, -1, 1),
        class = "cmna_invalid_argument"
    )
})

test_that("bisection validates its arguments", {
    expect_error(
        bisection(1, 0, 1),
        "f must be a function",
        class = "cmna_invalid_argument"
    )
    expect_error(
        bisection(identity, c(0, 1), 2),
        "a must be",
        class = "cmna_invalid_argument"
    )
    expect_error(
        bisection(identity, 0, Inf),
        "b must be",
        class = "cmna_invalid_argument"
    )
    expect_error(
        bisection(identity, -1, 1, tol = 0),
        "tol must be",
        class = "cmna_invalid_argument"
    )
    expect_error(
        bisection(identity, -1, 1, m = 0),
        "m must be",
        class = "cmna_invalid_argument"
    )
    expect_error(
        bisection(identity, -1, 1, m = 1.5),
        "m must be",
        class = "cmna_invalid_argument"
    )
})

test_that("bisection rejects non-finite function values", {
    expect_error(
        bisection(function(x) NaN, 0, 1),
        "f\\(a\\) must be",
        class = "cmna_non_finite_value"
    )
    expect_error(
        bisection(function(x) NaN, 0, 1),
        class = "cmna_numerical_breakdown"
    )

    f <- function(x) {
        if (x == 0.5) {
            return(Inf)
        }
        x - 0.25
    }

    expect_error(
        bisection(f, 0, 1),
        "f\\(midpoint\\) must be",
        class = "cmna_non_finite_value"
    )
})

test_that("bisection errors when the iteration limit is exhausted", {
    f <- function(x) x^2 - 2

    expect_error(
        bisection(f, 1, 2, tol = 1e-15, m = 1),
        "maximum number of iterations exceeded",
        class = "cmna_iteration_limit"
    )
    expect_error(
        bisection(f, 1, 2, tol = 1e-15, m = 1),
        class = "cmna_convergence_failure"
    )
})

test_that("bisection detects floating-point midpoint collapse", {
    a <- 1
    b <- a + .Machine$double.eps

    g <- function(x) {
        if (x == a) {
            return(-1)
        }
        1
    }

    expect_error(
        bisection(g, a, b, tol = .Machine$double.xmin),
        "can no longer be reduced",
        class = "cmna_stagnation"
    )
})
