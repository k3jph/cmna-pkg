## Independent mathematical oracle tests for integration

test_that("trap integrates x^2 from 0 to 1 with known error bound", {
    f <- function(x) x^2
    exact <- 1/3
    result <- trap(f, 0, 1, m = 1000)
    expect_equal(result, exact, tolerance = 1e-6)
})

test_that("simp integrates x^4 on [0,1] with known answer", {
    f <- function(x) x^4
    exact <- 1/5
    result <- simp(f, 0, 1, m = 100)
    expect_equal(result, exact, tolerance = 1e-8)
})

test_that("midpt integrates sin(x) on [0, pi] exactly", {
    exact <- 2
    result <- midpt(sin, 0, pi, m = 1000)
    expect_equal(result, exact, tolerance = 1e-5)
})

test_that("all Newton-Cotes integrate x^2 from 0 to 1 = 1/3", {
    f <- function(x) x^2
    exact <- 1/3
    expect_equal(midpt(f, 0, 1, m = 100), exact, tolerance = 1e-4)
    expect_equal(trap(f, 0, 1, m = 100), exact, tolerance = 1e-4)
    expect_equal(simp(f, 0, 1, m = 100), exact, tolerance = 1e-8)
    expect_equal(simp38(f, 0, 1, m = 99), exact, tolerance = 1e-8)
})

test_that("simp is exact for degree <= 3 polynomials", {
    f2 <- function(x) x^2
    f3 <- function(x) x^3
    expect_equal(simp(f2, 0, 1, m = 2), 1/3, tolerance = 1e-14)
    expect_equal(simp(f3, 0, 1, m = 2), 1/4, tolerance = 1e-14)
})

test_that("odd function on symmetric interval integrates to zero", {
    f <- function(x) x^3
    expect_equal(trap(f, -1, 1, m = 100), 0, tolerance = 1e-10)
    expect_equal(simp(f, -1, 1, m = 100), 0, tolerance = 1e-14)
})

test_that("romberg achieves high accuracy on smooth function", {
    f <- function(x) 1 / (1 + x^2)
    exact <- pi / 4
    result <- romberg(f, 0, 1, m = 10)
    expect_equal(result, exact, tolerance = 1e-10)
})

test_that("adaptint handles oscillatory function", {
    f <- function(x) sin(10 * x)
    exact <- (1 - cos(10)) / 10
    result <- adaptint(f, 0, 1)
    expect_equal(result, exact, tolerance = 1e-4)
})

test_that("gauss.legendre is exact for degree <= 9 polynomial (m=5)", {
    f5 <- function(x) x^9
    result <- gauss.legendre(f5, m = 5)
    expect_equal(result, 0, tolerance = 1e-10)

    f4 <- function(x) x^4
    result2 <- gauss.legendre(f4, m = 5)
    expect_equal(result2, 2/5, tolerance = 1e-10)
})

test_that("mcint2 approximates unit square area", {
    set.seed(123)
    f <- function(x, y) rep(1, length(x))
    result <- mcint2(f, c(0, 1), c(0, 1), m = 10000)
    expect_equal(result, 1, tolerance = 0.05)
})

test_that("discmethod computes volume of cone", {
    f <- function(x) x
    exact_vol <- pi / 3
    result <- discmethod(f, 0, 1)
    expect_equal(result, exact_vol, tolerance = 0.01)
})

test_that("shellmethod computes volume of paraboloid shell", {
    f <- function(x) x^2
    exact_vol <- pi / 2
    result <- shellmethod(f, 0, 1)
    expect_equal(result, exact_vol, tolerance = 0.01)
})
