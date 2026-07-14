## Tests for safe evaluation of user-supplied callback functions

test_that("integration handles scalar constant function", {
    f <- function(x) 5
    expect_equal(trap(f, 0, 1, m = 10), 5, tolerance = 1e-10)
    expect_equal(simp(f, 0, 1, m = 10), 5, tolerance = 1e-10)
    expect_equal(midpt(f, 0, 1, m = 10), 5, tolerance = 1e-10)
    expect_equal(simp38(f, 0, 1, m = 9), 5, tolerance = 1e-10)
})

test_that("integration handles properly vectorized constant", {
    f <- function(x) rep(5, length(x))
    expect_equal(trap(f, 0, 1, m = 10), 5, tolerance = 1e-10)
    expect_equal(simp(f, 0, 1, m = 10), 5, tolerance = 1e-10)
})

test_that("integration handles standard vectorized function", {
    expect_equal(trap(sin, 0, pi, m = 1000), 2, tolerance = 1e-5)
    expect_equal(simp(sin, 0, pi, m = 100), 2, tolerance = 1e-8)
})

test_that("integration rejects wrong-length return", {
    f <- function(x) c(1, 2)
    expect_error(trap(f, 0, 1, m = 10), class = "cmna_invalid_argument")
    expect_error(simp(f, 0, 1, m = 10), class = "cmna_invalid_argument")
})

test_that("integration rejects non-numeric return", {
    f <- function(x) "hello"
    expect_error(trap(f, 0, 1, m = 10), class = "cmna_invalid_argument")
})

test_that("integration rejects NaN/Inf return", {
    f_nan <- function(x) rep(NaN, length(x))
    expect_error(trap(f_nan, 0, 1, m = 10), class = "cmna_numerical_breakdown")

    f_inf <- function(x) rep(Inf, length(x))
    expect_error(trap(f_inf, 0, 1, m = 10), class = "cmna_numerical_breakdown")
})

test_that("integration rejects list return", {
    f <- function(x) list(x)
    expect_error(trap(f, 0, 1, m = 10), class = "cmna_invalid_argument")
})

test_that("gaussint handles scalar constant", {
    x <- c(-1/sqrt(3), 1/sqrt(3))
    w <- c(1, 1)
    f <- function(x) 3
    expect_equal(gaussint(f, x, w), 6, tolerance = 1e-10)
})

test_that("mcint handles scalar constant", {
    set.seed(42)
    f <- function(x) 7
    result <- mcint(f, 0, 1, m = 10000)
    expect_equal(result, 7, tolerance = 0.1)
})

test_that("mcint2 handles scalar constant", {
    set.seed(42)
    f <- function(x, y) 1
    result <- mcint2(f, c(0, 1), c(0, 1), m = 10000)
    expect_equal(result, 1, tolerance = 0.1)
})
