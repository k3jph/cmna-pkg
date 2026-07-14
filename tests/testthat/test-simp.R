test_that("simp integrates x^2 on [0,1] to 1/3", {
    f <- function(x) x^2
    expect_equal(simp(f, 0, 1, m = 100), 1 / 3, tolerance = 1e-6)
})

test_that("simp integrates 1/x on [1,10] to log(10)", {
    f <- function(x) 1 / x
    expect_equal(simp(f, 1, 10, m = 100), log(10), tolerance = 1e-6)
})

test_that("simp integrates sin^2 + cos^2 = 1 on [-pi, pi] to 2*pi", {
    f <- function(x) sin(x)^2 + cos(x)^2
    expect_equal(simp(f, -pi, pi, m = 100), 2 * pi, tolerance = 1e-6)
})

test_that("simp integrates polynomials up to degree 3 exactly", {
    f <- function(x) x^3
    expect_equal(simp(f, 0, 1, m = 1), 0.25, tolerance = 1e-10)
})

test_that("simp is more accurate than trap for smooth functions", {
    f <- function(x) x^2
    e_simp <- abs(simp(f, 0, 1, m = 10) - 1 / 3)
    e_trap <- abs(trap(f, 0, 1, m = 10) - 1 / 3)
    expect_lt(e_simp, e_trap)
})

test_that("simp validates its arguments", {
    expect_error(simp(1, 0, 1), class = "cmna_invalid_argument")
    expect_error(simp(identity, "a", 1), class = "cmna_invalid_argument")
    expect_error(simp(identity, 0, 1, m = 0), class = "cmna_invalid_argument")
})
