## Cross-method integration invariants

test_that("all Newton-Cotes methods integrate constant exactly", {
    f <- function(x) rep(5, length(x))
    expect_equal(midpt(f, 0, 1, m = 10), 5, tolerance = 1e-10)
    expect_equal(trap(f, 0, 1, m = 10), 5, tolerance = 1e-10)
    expect_equal(simp(f, 0, 1, m = 10), 5, tolerance = 1e-10)
    expect_equal(simp38(f, 0, 1, m = 12), 5, tolerance = 1e-10)
})

test_that("all Newton-Cotes methods integrate linear exactly", {
    f <- function(x) 2 * x + 1
    exact <- 2
    expect_equal(midpt(f, 0, 1, m = 10), exact, tolerance = 1e-10)
    expect_equal(trap(f, 0, 1, m = 10), exact, tolerance = 1e-10)
    expect_equal(simp(f, 0, 1, m = 10), exact, tolerance = 1e-10)
    expect_equal(simp38(f, 0, 1, m = 12), exact, tolerance = 1e-10)
})

test_that("Simpson's rule integrates cubics exactly", {
    f <- function(x) x^3
    exact <- 0.25
    expect_equal(simp(f, 0, 1, m = 10), exact, tolerance = 1e-10)
})

test_that("higher-order methods are more accurate for smooth functions", {
    f <- function(x) exp(x)
    exact <- exp(1) - 1
    m <- 10
    err_midpt <- abs(midpt(f, 0, 1, m) - exact)
    err_trap <- abs(trap(f, 0, 1, m) - exact)
    err_simp <- abs(simp(f, 0, 1, m) - exact)
    expect_lt(err_simp, err_trap)
    expect_lt(err_simp, err_midpt)
})

test_that("romberg integrates exp(x) accurately", {
    f <- function(x) exp(x)
    exact <- exp(1) - 1
    result <- romberg(f, 0, 1, m = 10)
    expect_equal(result, exact, tolerance = 1e-8)
})

test_that("adaptint integrates exp(x) accurately", {
    f <- function(x) exp(x)
    exact <- exp(1) - 1
    result <- adaptint(f, 0, 1)
    expect_equal(result, exact, tolerance = 1e-6)
})

test_that("gauss.legendre integrates polynomial exactly", {
    f <- function(x) x^2
    result <- gauss.legendre(f, m = 5)
    expect_equal(result, 2/3, tolerance = 1e-10)
})

test_that("mcint approximates known integral", {
    set.seed(42)
    f <- function(x) x^2
    result <- mcint(f, 0, 1, m = 50000)
    expect_equal(result, 1/3, tolerance = 0.02)
})

test_that("shell method computes volume", {
    f <- function(x) rep(1, length(x))
    vol <- shellmethod(f, 0, 1)
    expect_equal(vol, pi, tolerance = 0.01)
})

test_that("disc method computes volume", {
    f <- function(x) rep(1, length(x))
    vol <- discmethod(f, 0, 1)
    expect_equal(vol, pi, tolerance = 0.01)
})
