test_that("linterp returns coefficients for horner", {
    coefs <- linterp(0, 0, 1, 1)
    expect_equal(length(coefs), 2)
    expect_equal(horner(0, coefs), 0)
    expect_equal(horner(1, coefs), 1)
})

test_that("linterp interpolates known points", {
    coefs <- linterp(3, 2, 7, -2)
    expect_equal(horner(3, coefs), 2)
    expect_equal(horner(7, coefs), -2)
})

test_that("linterp for horizontal line", {
    coefs <- linterp(0, 5, 10, 5)
    expect_equal(coefs[2], 0)
    expect_equal(coefs[1], 5)
})
