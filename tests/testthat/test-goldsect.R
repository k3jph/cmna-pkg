test_that("goldsectmin finds minimum of x^2 - 3x + 3", {
    f <- function(x) x^2 - 3 * x + 3
    result <- goldsectmin(f, 0, 5)
    expect_equal(result, 1.5, tolerance = 1e-3)
})

test_that("goldsectmax finds maximum of -(x-2)^2", {
    f <- function(x) -(x - 2)^2
    result <- goldsectmax(f, 0, 5)
    expect_equal(result, 2, tolerance = 1e-3)
})

test_that("goldsectmin finds minimum of (x-3)^2", {
    f <- function(x) (x - 3)^2
    result <- goldsectmin(f, 0, 10)
    expect_equal(result, 3, tolerance = 1e-3)
})

test_that("goldsect validates its arguments", {
    expect_error(goldsectmin(1, 0, 5), class = "cmna_invalid_argument")
    expect_error(goldsectmin(identity, "a", 5), class = "cmna_invalid_argument")
})
