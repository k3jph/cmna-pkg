test_that("adaptint integrates x^2 on [0,1]", {
    f <- function(x) x^2
    expect_equal(adaptint(f, 0, 1, n = 10), 1 / 3, tolerance = 1e-4)
})

test_that("adaptint integrates sin on [0, pi]", {
    expect_equal(adaptint(sin, 0, pi, n = 10), 2, tolerance = 1e-4)
})

test_that("adaptint validates its arguments", {
    expect_error(adaptint(1, 0, 1), class = "cmna_invalid_argument")
    expect_error(adaptint(identity, "a", 1), class = "cmna_invalid_argument")
})
