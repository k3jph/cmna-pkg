test_that("mcint approximates integral of x^2 on [0,1]", {
    set.seed(42)
    f <- function(x) x^2
    result <- mcint(f, 0, 1, m = 100000)
    expect_equal(result, 1 / 3, tolerance = 0.01)
})

test_that("mcint2 approximates integral of x*y on unit square", {
    set.seed(42)
    f <- function(x, y) x * y
    result <- mcint2(f, c(0, 1), c(0, 1), m = 100000)
    expect_equal(result, 0.25, tolerance = 0.01)
})

test_that("mcint validates its arguments", {
    expect_error(mcint(1, 0, 1), class = "cmna_invalid_argument")
    expect_error(mcint(identity, "a", 1), class = "cmna_invalid_argument")
})
