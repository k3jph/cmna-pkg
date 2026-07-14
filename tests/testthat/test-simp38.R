test_that("simp38 integrates x^2 on [0,1] to 1/3", {
    f <- function(x) x^2
    expect_equal(simp38(f, 0, 1, m = 100), 1 / 3, tolerance = 1e-6)
})

test_that("simp38 integrates 1/x on [1,10] to log(10)", {
    f <- function(x) 1 / x
    expect_equal(simp38(f, 1, 10, m = 100), log(10), tolerance = 1e-6)
})

test_that("simp38 integrates sin^2 + cos^2 = 1 on [-pi, pi] to 2*pi", {
    f <- function(x) sin(x)^2 + cos(x)^2
    expect_equal(simp38(f, -pi, pi, m = 100), 2 * pi, tolerance = 1e-6)
})

test_that("simp38 validates its arguments", {
    expect_error(simp38(1, 0, 1), class = "cmna_invalid_argument")
    expect_error(simp38(identity, "a", 1), class = "cmna_invalid_argument")
    expect_error(simp38(identity, 0, 1, m = 0), class = "cmna_invalid_argument")
})
