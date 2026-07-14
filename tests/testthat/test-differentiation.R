## Tests for differentiation: symdiff, rdiff, findiff2

test_that("findiff approximates derivative of x^2", {
    f <- function(x) x^2
    expect_equal(findiff(f, 1), 2, tolerance = 0.01)
    expect_equal(findiff(f, 3), 6, tolerance = 0.01)
})

test_that("symdiff is more accurate than findiff", {
    f <- function(x) x^3
    exact <- 3 * 2^2
    err_findiff <- abs(findiff(f, 2) - exact)
    err_symdiff <- abs(symdiff(f, 2) - exact)
    expect_lt(err_symdiff, err_findiff)
})

test_that("rdiff has high accuracy", {
    f <- function(x) sin(x)
    expect_equal(rdiff(f, 0), cos(0), tolerance = 1e-6)
    expect_equal(rdiff(f, pi/4), cos(pi/4), tolerance = 1e-6)
})

test_that("findiff2 computes second derivative", {
    f <- function(x) x^3
    expect_equal(findiff2(f, 2, 0.01), 12, tolerance = 0.1)
})

test_that("findiff2 of quadratic gives constant", {
    f <- function(x) 3 * x^2 + 2 * x + 1
    expect_equal(findiff2(f, 0, 0.01), 6, tolerance = 0.1)
    expect_equal(findiff2(f, 5, 0.01), 6, tolerance = 0.1)
})
