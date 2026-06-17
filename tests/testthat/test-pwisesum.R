test_that("pwisesum sums ordinary numeric vectors", {
    expect_equal(pwisesum(c(1, 2, 3, 4)), 10)
    expect_equal(pwisesum(c(-1, -2, 3)), 0)
    expect_equal(pwisesum(c(1.5, 2.25)), 3.75)
})

test_that("pwisesum handles empty input", {
    expect_equal(pwisesum(numeric()), 0)
    expect_equal(pwisesum(NULL), 0)
})

test_that("pwisesum returns a scalar for a single element", {
    expect_equal(pwisesum(c(7)), 7)
})

test_that("pwisesum validates numeric input", {
    expect_error(pwisesum("string"), class = "cmna_invalid_argument")
    expect_error(pwisesum(list(1, 2, 3)), class = "cmna_invalid_argument")
})

test_that("pwisesum follows base R non-finite propagation", {
    expect_true(is.na(pwisesum(c(1, NA_real_))))
    expect_true(is.nan(pwisesum(c(1, NaN))))
    expect_equal(pwisesum(c(1, Inf)), Inf)
})

test_that("pwisesum matches base R on a stable ordinary case", {
    x <- c(4, -2, 1, -1, 0.5, 0.25)
    expect_equal(pwisesum(x), sum(x))
})
