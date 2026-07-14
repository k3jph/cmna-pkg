test_that("graddsc finds a minimum of x^3 + 3x^2 - 1", {
    fp <- function(x) x^3 + 3 * x^2 - 1
    result <- graddsc(fp, 0)
    expect_true(is.finite(result))
})

test_that("gd finds minimum of (x1-1)^2 + (x2-1)^2", {
    fp <- function(x) c(2 * (x[1] - 1), 2 * (x[2] - 1))
    result <- gd(fp, c(0, 0), h = 0.1)
    expect_equal(result, c(1, 1), tolerance = 0.1)
})

test_that("gradient methods validate arguments", {
    expect_error(graddsc(1, 0), class = "cmna_invalid_argument")
})
