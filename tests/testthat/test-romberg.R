test_that("romberg integrates x^2 on [0,1] accurately", {
    f <- function(x) x^2
    expect_equal(romberg(f, 0, 1, m = 5), 1 / 3, tolerance = 1e-10)
})

test_that("romberg integrates 1/x on [1,10]", {
    f <- function(x) 1 / x
    expect_equal(romberg(f, 1, 10, m = 10), log(10), tolerance = 1e-10)
})

test_that("romberg tab returns full table", {
    f <- function(x) x^2
    R <- romberg(f, 0, 1, m = 3, tab = TRUE)
    expect_true(is.matrix(R))
    expect_equal(nrow(R), 3)
    expect_equal(ncol(R), 3)
    expect_equal(R[3, 3], 1 / 3, tolerance = 1e-10)
})

test_that("romberg validates its arguments", {
    expect_error(romberg(1, 0, 1, m = 3), class = "cmna_invalid_argument")
    expect_error(romberg(identity, "a", 1, m = 3), class = "cmna_invalid_argument")
})
