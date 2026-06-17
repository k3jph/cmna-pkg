test_that("naivesum sums ordinary numeric vectors", {
    expect_equal(naivesum(c(1, 2, 3, 4)), 10)
    expect_equal(naivesum(c(-1, -2, 3)), 0)
    expect_equal(naivesum(c(1.5, 2.25)), 3.75)
})

test_that("naivesum handles empty input", {
    expect_equal(naivesum(numeric()), 0)
    expect_equal(naivesum(NULL), 0)
})

test_that("naivesum returns a scalar for a single element", {
    expect_equal(naivesum(c(7)), 7)
})

test_that("naivesum validates numeric input", {
    expect_error(naivesum("string"), class = "cmna_invalid_argument")
    expect_error(naivesum(list(1, 2, 3)), class = "cmna_invalid_argument")
})

test_that("naivesum follows base R non-finite propagation", {
    expect_true(is.na(naivesum(c(1, NA_real_))))
    expect_true(is.nan(naivesum(c(1, NaN))))
    expect_equal(naivesum(c(1, Inf)), Inf)
})

test_that("naivesum is intentionally left-to-right", {
    x <- c(1, rep(1e-16, 1000), -1)

    expect_equal(naivesum(x), 0)
    expect_gt(kahansum(x), naivesum(x))
})
