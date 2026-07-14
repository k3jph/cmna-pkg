test_that("wave returns a matrix with correct dimensions", {
    x <- seq(0, 1, 0.05)
    u <- sin(x * pi * 2)
    u[11:21] <- 0
    result <- wave(u, 2, 0.05, 0.02, 10)
    expect_true(is.matrix(result))
    expect_equal(nrow(result), 11)
    expect_equal(ncol(result), length(u))
})
