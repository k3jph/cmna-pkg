library("testthat")
context("betterpoly")

test_that("betterpoly evaluates known polynomials correctly", {
  expect_equal(betterpoly(1, c(1, 2, 3)), 6) # 1 + 2*1 + 3*1^2 = 6
  expect_equal(betterpoly(0, c(5, 0, 0)), 5) # Testing zero
  expect_equal(betterpoly(-1, c(1, -1, 1)), 3) # Testing negative x
  expect_equal(betterpoly(1, c(0.5, 0.25)), 0.75) # Testing fractional coefficients
})

test_that("betterpoly handles edge cases", {
  expect_error(betterpoly(1, c())) # Empty coefficients
  expect_equal(betterpoly(1, c(5)), 5) # Single coefficient
})

test_that("betterpoly handles random coefficients and values", {
  for (i in 1:5) {
    coefs <- runif(10, -10, 10)
    x_val <- runif(1, -10, 10)
    expect_equal(betterpoly(x_val, coefs), sum(coefs * x_val^(0:(length(coefs) - 1))))
  }
})

test_that("betterpoly handles large coefficients and values", {
  large_coefs <- rep(10^6, 10)
  expect_equal(betterpoly(1, large_coefs), sum(large_coefs))
})

test_that("betterpoly rejects non-numeric input", {
  expect_error(betterpoly("a", c(1, 2, 3)))
  expect_error(betterpoly(1, c("a", "b", "c")))
})
