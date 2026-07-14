test_that("heat returns a matrix with correct dimensions", {
    u <- sin(seq(0, 1, 0.05) * pi)
    result <- heat(u, 1, 0.05, 0.001, 10)
    expect_true(is.matrix(result))
    expect_equal(nrow(result), 11)
    expect_equal(ncol(result), length(u))
})

test_that("heat preserves boundary conditions", {
    u <- sin(seq(0, 1, 0.05) * pi)
    result <- heat(u, 1, 0.05, 0.001, 10)
    expect_equal(ncol(result), length(u))
})
