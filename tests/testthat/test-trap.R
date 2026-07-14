test_that("trap integrates x^2 on [0,1] to 1/3", {
    f <- function(x) x^2
    expect_equal(trap(f, 0, 1, m = 1000), 1 / 3, tolerance = 1e-4)
})

test_that("trap integrates 1/x on [1,10] to log(10)", {
    f <- function(x) 1 / x
    expect_equal(trap(f, 1, 10, m = 1000), log(10), tolerance = 1e-4)
})

test_that("trap integrates sin^2 + cos^2 = 1 on [-pi, pi] to 2*pi", {
    f <- function(x) sin(x)^2 + cos(x)^2
    expect_equal(trap(f, -pi, pi, m = 100), 2 * pi, tolerance = 1e-3)
})

test_that("trap integrates constant function exactly", {
    f <- function(x) rep(5, length(x))
    expect_equal(trap(f, 0, 3, m = 1), 15, tolerance = 1e-10)
})

test_that("trap integrates linear function exactly", {
    f <- function(x) 2 * x + 1
    expect_equal(trap(f, 0, 3, m = 1), 12, tolerance = 1e-10)
})

test_that("trap improves with more subintervals", {
    f <- function(x) x^2
    e10 <- abs(trap(f, 0, 1, m = 10) - 1 / 3)
    e100 <- abs(trap(f, 0, 1, m = 100) - 1 / 3)
    expect_lt(e100, e10)
})

test_that("trap validates its arguments", {
    expect_error(trap(1, 0, 1), class = "cmna_invalid_argument")
    expect_error(trap(identity, "a", 1), class = "cmna_invalid_argument")
    expect_error(trap(identity, 0, Inf), class = "cmna_invalid_argument")
    expect_error(trap(identity, 0, 1, m = 0), class = "cmna_invalid_argument")
})
