test_that("gdls solves a simple least squares problem", {
    A <- matrix(c(1, 1, 1, 1, 2, 3), ncol = 2)
    b <- c(1, 2, 3)
    result <- gdls(A, b, alpha = 0.05, m = 10000)
    expect_equal(as.vector(A %*% result), b, tolerance = 0.1)
})
