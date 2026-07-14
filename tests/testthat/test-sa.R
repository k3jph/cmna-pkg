test_that("sa finds a good solution for a simple function", {
    set.seed(42)
    f <- function(x) (x - 3)^2
    result <- sa(f, 0)
    expect_equal(result, 3, tolerance = 1)
})

test_that("sa improves the objective value", {
    set.seed(42)
    f <- function(x) (x[1] - 1)^2 + (x[2] - 1)^2
    x0 <- c(10, 10)
    result <- sa(f, x0)
    expect_lt(f(result), f(x0))
})

test_that("sa validates its arguments", {
    expect_error(sa(1, 0), class = "cmna_invalid_argument")
})
