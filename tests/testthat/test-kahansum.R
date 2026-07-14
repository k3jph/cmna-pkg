test_that("kahansum sums ordinary numeric vectors", {
    expect_equal(kahansum(c(1, 2, 3, 4)), 10)
    expect_equal(kahansum(c(-1, -2, 3)), 0)
    expect_equal(kahansum(c(1.5, 2.25)), 3.75)
})

test_that("kahansum handles empty input", {
    expect_equal(kahansum(numeric()), 0)
    expect_equal(kahansum(NULL), 0)
})

test_that("kahansum returns a scalar for a single element", {
    expect_equal(kahansum(c(7)), 7)
})

test_that("kahansum validates numeric input", {
    expect_error(kahansum("string"), class = "cmna_invalid_argument")
    expect_error(kahansum(list(1, 2, 3)), class = "cmna_invalid_argument")
})

test_that("kahansum follows base R non-finite propagation", {
    expect_true(is.na(kahansum(c(1, NA_real_))))
    expect_true(is.nan(kahansum(c(1, NaN))))
    expect_equal(kahansum(c(1, Inf)), Inf)
})

test_that("kahansum recovers low-order additions lost by naive summation", {
    x <- c(1, rep(1e-16, 1000), -1)

    expect_equal(naivesum(x), 0)
    expect_equal(kahansum(x), 1e-13, tolerance = 1e-3)
    expect_lt(abs(kahansum(x) - 1e-13), abs(naivesum(x) - 1e-13))
})
