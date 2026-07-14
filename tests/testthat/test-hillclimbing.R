test_that("hillclimbing finds a local minimum of himmelblau", {
    set.seed(42)
    f <- function(x) (x[1]^2 + x[2] - 11)^2 + (x[1] + x[2]^2 - 7)^2
    result <- hillclimbing(f, c(0, 0), m = 10000)
    expect_lt(f(result), f(c(0, 0)))
})

test_that("hillclimbing validates its arguments", {
    expect_error(hillclimbing(1, c(0, 0)), class = "cmna_invalid_argument")
})
