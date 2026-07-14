test_that("cubicspline returns correct structure", {
    x <- c(1, 2, 3)
    y <- c(2, 3, 5)
    result <- cubicspline(x, y)
    expect_true(is.list(result))
    expect_true(all(c("a", "b", "c", "d") %in% names(result)))
    expect_equal(length(result$a), 2)
})

test_that("cubicspline interpolates the nodes", {
    x <- c(1, 2, 3)
    y <- c(2, 3, 5)
    result <- cubicspline(x, y)
    expect_equal(result$a[1], y[1])
    expect_equal(result$a[2], y[2])
})

test_that("cubicspline with 4 points", {
    x <- c(-1, 0, 1, 2)
    y <- c(-2, 0, 2, 1)
    result <- cubicspline(x, y)
    expect_equal(length(result$a), 3)
})
