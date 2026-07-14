test_that("gaussint with 2-point Legendre integrates cubic exactly", {
    w <- c(1, 1)
    x <- c(-1 / sqrt(3), 1 / sqrt(3))
    f <- function(x) x^3 + x + 1
    expect_equal(gaussint(f, x, w), 2, tolerance = 1e-10)
})

test_that("gauss.legendre integrates polynomial", {
    f <- function(x) x^2 + 1
    result <- gauss.legendre(f, m = 5)
    expect_equal(result, 2 + 2 / 3, tolerance = 1e-10)
})

test_that("gaussint validates its arguments", {
    expect_error(gaussint(1, c(0), c(1)), class = "cmna_invalid_argument")
})
