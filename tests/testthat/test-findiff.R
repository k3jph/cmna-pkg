test_that("findiff approximates the derivative of sin at pi", {
    expect_equal(findiff(sin, pi, 1e-5), cos(pi), tolerance = 1e-4)
})

test_that("symdiff is more accurate than findiff", {
    e_fwd <- abs(findiff(sin, pi, 1e-5) - cos(pi))
    e_sym <- abs(symdiff(sin, pi, 1e-5) - cos(pi))
    expect_lt(e_sym, e_fwd)
})

test_that("findiff2 approximates the second derivative", {
    expect_equal(findiff2(sin, pi, 1e-3), -sin(pi), tolerance = 1e-3)
})

test_that("rdiff improves with more Richardson steps", {
    e1 <- abs(rdiff(sin, 1, n = 1) - cos(1))
    e5 <- abs(rdiff(sin, 1, n = 5) - cos(1))
    expect_lt(e5, e1)
})

test_that("derivative of x^2 at x = 3 is 6", {
    f <- function(x) x^2
    expect_equal(symdiff(f, 3, 1e-5), 6, tolerance = 1e-5)
})

test_that("findiff validates its arguments", {
    expect_error(findiff(1, 0), class = "cmna_invalid_argument")
    expect_error(findiff(sin, "a"), class = "cmna_invalid_argument")
})
