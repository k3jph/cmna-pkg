test_that("refmatrix produces upper triangular form", {
    A <- matrix(c(1, 2, -7, -1, -1, 1, 2, 1, 5), 3)
    R <- refmatrix(A)
    expect_equal(R[2, 1], 0)
    expect_equal(R[3, 1], 0)
    expect_equal(R[3, 2], 0)
})

test_that("rrefmatrix produces reduced row echelon form", {
    A <- matrix(c(1, 2, -7, -1, -1, 1, 2, 1, 5), 3)
    R <- rrefmatrix(A)
    expect_equal(R[1, 1], 1)
    expect_equal(R[2, 2], 1)
    expect_equal(R[3, 3], 1)
    expect_equal(R[1, 2], 0)
    expect_equal(R[1, 3], 0)
})

test_that("solvematrix solves a 3x3 system", {
    A <- matrix(c(1, 0, 0, 0, 1, 0, 0, 0, 1), 3)
    b <- c(1, 2, 3)
    expect_equal(solvematrix(A, b), b)
})

test_that("solvematrix agrees with solve()", {
    A <- matrix(c(5, 2, 1, 2, 7, 3, 3, 4, 8), 3)
    b <- c(40, 39, 55)
    x <- solvematrix(A, b)
    expect_equal(as.vector(A %*% x), b, tolerance = 1e-10)
})
