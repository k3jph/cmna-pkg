test_that("discmethod computes volume of cone", {
    f <- function(x) x
    volume <- discmethod(f, 0, 1)
    expect_equal(volume, pi / 3, tolerance = 0.01)
})

test_that("shellmethod computes volume", {
    f <- function(x) x^2
    volume <- shellmethod(f, 1, 2)
    expect_true(is.finite(volume))
    expect_gt(volume, 0)
})

test_that("revolution validates its arguments", {
    expect_error(discmethod(1, 0, 1), class = "cmna_invalid_argument")
    expect_error(shellmethod(1, 0, 1), class = "cmna_invalid_argument")
})
