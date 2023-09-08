library("testthat")
context("kahansum")

l <- 1:10^6

test_that("adds correctly", {
  for (i in 1:5) {
    n <- sample(l, 1)
    bound <- sample(l, 2)
    bound.u <- max(bound) - 10^6 / 2
    bound.l <- min(bound) - 10^6 / 2
    x <- runif(n, bound.l, bound.u)
    expect_equal(kahansum(x), sum(x))
  }
})

test_that("edge cases like an empty vector", {
  expect_equal(kahansum(c()), sum(c()))
  expect_equal(kahansum(NULL), sum(NULL))
})

test_that("edge cases like a single-element vector", {
  expect_equal(kahansum(c(1)), sum(c(1)))
})

test_that("input unexpected types", {
  expect_error(kahansum("string"))
})

test_that("for precision", {
  expect_equal(kahansum(c(1e-10, 1, 1e-10)), sum(c(1e-10, 1, 1e-10)), tolerance = 1e-20)
})
