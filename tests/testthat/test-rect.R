test_that("midpt integrates x^2 on [0,1] to 1/3", {
    f <- function(x) x^2
    expect_equal(midpt(f, 0, 1, m = 1000), 1 / 3, tolerance = 1e-4)
})

test_that("midpt integrates 1/x on [1,10] to log(10)", {
    f <- function(x) 1 / x
    expect_equal(midpt(f, 1, 10, m = 1000), log(10), tolerance = 1e-4)
})

test_that("midpt integrates constant function exactly", {
    f <- function(x) rep(5, length(x))
    expect_equal(midpt(f, 0, 3, m = 10), 15, tolerance = 1e-10)
})

test_that("midpt improves with more subintervals", {
    f <- function(x) x^2
    e10 <- abs(midpt(f, 0, 1, m = 10) - 1 / 3)
    e100 <- abs(midpt(f, 0, 1, m = 100) - 1 / 3)
    expect_lt(e100, e10)
})

test_that("midpt validates its arguments", {
    expect_error(midpt(1, 0, 1), class = "cmna_invalid_argument")
    expect_error(midpt(identity, "a", 1), class = "cmna_invalid_argument")
    expect_error(midpt(identity, 0, 1, m = 0), class = "cmna_invalid_argument")
})
