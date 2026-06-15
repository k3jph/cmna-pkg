test_that("secant finds a known root", {
    f <- function(x) x^2 - 2

    root <- secant(f, 1, 2, tol = 1e-10)

    expect_equal(root, sqrt(2), tolerance = 1e-10)
})

test_that("secant returns an initial estimate that is already a root", {
    f <- function(x) x - 2

    expect_identical(secant(f, 2, 3), 2)
    expect_identical(secant(f, 1, 2), 2)
})

test_that("secant validates its arguments", {
    expect_error(secant(1, 0, 1), "f must be a function")
    expect_error(secant(identity, c(0, 1), 2), "x0 must be")
    expect_error(secant(identity, 0, c(1, 2)), "x1 must be")
    expect_error(secant(identity, Inf, 1), "x0 must be")
    expect_error(secant(identity, 0, Inf), "x1 must be")
    expect_error(secant(identity, 1, 1), "must be distinct")
    expect_error(secant(identity, 0, 1, tol = 0), "tol must be")
    expect_error(secant(identity, 0, 1, m = 0), "m must be")
    expect_error(secant(identity, 0, 1, m = 1.5), "m must be")
})

test_that("secant rejects non-finite function values", {
    expect_error(
        secant(function(x) NaN, 0, 1),
        "f\\(x0\\) must be"
    )

    expect_error(
        secant(function(x) if (x == 0) -1 else Inf, 0, 1),
        "f\\(x1\\) must be"
    )
})

test_that("secant rejects a zero denominator", {
    expect_error(
        secant(function(x) x^2 + 1, -1, 1),
        "secant denominator is zero"
    )
})

test_that("secant rejects a non-finite next estimate", {
    expect_error(
        secant(function(x) if (x == 0) 1e308 else -1e308, 0, 1e308),
        "next estimate must be"
    )
})

test_that("secant errors when the iteration limit is exhausted", {
    f <- function(x) x^2 - 2

    expect_error(
        secant(f, 1, 2, tol = 1e-15, m = 1),
        "maximum number of iterations exceeded"
    )
})
