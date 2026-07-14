test_that("Cholesky satisfies t(L) %*% L = A", {
    A <- matrix(c(5, 1, 2, 1, 9, 3, 2, 3, 7), 3)
    L <- choleskymatrix(A)
    expect_equal(t(L) %*% L, A, tolerance = 1e-10)
})

test_that("Cholesky of identity is identity", {
    I <- diag(3)
    L <- choleskymatrix(I)
    expect_equal(L, I, tolerance = 1e-10)
})

test_that("Cholesky of diagonal matrix", {
    D <- diag(c(4, 9, 16))
    L <- choleskymatrix(D)
    expect_equal(t(L) %*% L, D, tolerance = 1e-10)
})
