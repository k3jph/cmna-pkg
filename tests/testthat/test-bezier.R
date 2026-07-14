test_that("qbezier starts and ends at control points", {
    x <- c(0, 1, 2)
    y <- c(0, 2, 0)
    result <- qbezier(x, y, c(0, 1))
    expect_equal(result$x[1], 0)
    expect_equal(result$y[1], 0)
    expect_equal(result$x[2], 2)
    expect_equal(result$y[2], 0)
})

test_that("cbezier starts and ends at control points", {
    x <- c(0, 1, 2, 3)
    y <- c(0, 2, 2, 0)
    result <- cbezier(x, y, c(0, 1))
    expect_equal(result$x[1], 0)
    expect_equal(result$y[1], 0)
    expect_equal(result$x[2], 3)
    expect_equal(result$y[2], 0)
})

test_that("qbezier rejects wrong number of points", {
    expect_error(qbezier(1:2, 1:2, 0.5))
    expect_error(qbezier(1:4, 1:4, 0.5))
})

test_that("cbezier rejects wrong number of points", {
    expect_error(cbezier(1:3, 1:3, 0.5))
    expect_error(cbezier(1:5, 1:5, 0.5))
})
