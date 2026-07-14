test_that("tridiagmatrix solves a simple system", {
    D <- c(2, 3, 4)
    L <- c(1, 1)
    U <- c(1, 1)
    b <- c(3, 5, 5)
    x <- tridiagmatrix(L, D, U, b)
    A <- diag(D)
    A[cbind(2:3, 1:2)] <- L
    A[cbind(1:2, 2:3)] <- U
    expect_equal(as.vector(A %*% x), b, tolerance = 1e-10)
})

test_that("tridiagmatrix solves identity-like tridiagonal", {
    D <- c(1, 1, 1)
    L <- c(0, 0)
    U <- c(0, 0)
    b <- c(1, 2, 3)
    x <- tridiagmatrix(L, D, U, b)
    expect_equal(x, b, tolerance = 1e-10)
})
