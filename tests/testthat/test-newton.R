test_that("newton finds a known root", {
    f <- function(x) x^2 - 2
    fp <- function(x) 2 * x

    root <- newton(f, fp, 1, tol = 1e-10)

    expect_equal(root, sqrt(2), tolerance = 1e-10)
})

test_that("newton returns an initial estimate that is already a root", {
    f <- function(x) x - 2
    fp <- function(x) 1

    expect_identical(newton(f, fp, 2), 2)
})

test_that("newton validates its arguments", {
    expect_error(newton(1, identity, 1), "f must be a function")
    expect_error(newton(identity, 1, 1), "fp must be a function")
    expect_error(newton(identity, identity, c(0, 1)), "x must be")
    expect_error(newton(identity, identity, Inf), "x must be")
    expect_error(newton(identity, identity, 1, tol = 0), "tol must be")
    expect_error(newton(identity, identity, 1, m = 0), "m must be")
    expect_error(newton(identity, identity, 1, m = 1.5), "m must be")
})

test_that("newton rejects non-finite function and derivative values", {
    expect_error(
        newton(function(x) NaN, identity, 1),
        "f\\(x\\) must be"
    )

    expect_error(
        newton(function(x) x - 1, function(x) Inf, 0),
        "fp\\(x\\) must be"
    )
})

test_that("newton rejects a zero derivative", {
    expect_error(
        newton(function(x) x^2 + 1, function(x) 0, 1),
        "derivative is zero"
    )
})

test_that("newton rejects a non-finite next estimate", {
    expect_error(
        newton(function(x) 1e308, function(x) 1e-308, 0),
        "next estimate must be"
    )
})

test_that("newton errors when the iteration limit is exhausted", {
    f <- function(x) x^2 - 2
    fp <- function(x) 2 * x

    expect_error(
        newton(f, fp, 1, tol = 1e-15, m = 1),
        "maximum number of iterations exceeded"
    )
})
