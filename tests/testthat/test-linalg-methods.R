## Cross-method tests for linear algebra: rrefmatrix, solvematrix, cgmmatrix

test_that("rrefmatrix produces identity for invertible matrix", {
    A <- matrix(c(2, 1, 1, 3), nrow = 2)
    result <- rrefmatrix(A)
    expect_equal(result, diag(2), tolerance = 1e-10)
})

test_that("solvematrix solves Ax = b", {
    A <- matrix(c(2, 1, 1, 3), nrow = 2)
    b <- c(5, 7)
    x <- solvematrix(A, b)
    expect_equal(as.numeric(A %*% x), b, tolerance = 1e-10)
})

test_that("LU decomposition satisfies P*A = L*U", {
    A <- matrix(c(2, 1, 1, 0, 3, 1, 1, 1, 3), nrow = 3, byrow = TRUE)
    lu <- lumatrix(A)
    expect_equal(lu$P %*% A, lu$L %*% lu$U, tolerance = 1e-10)
})

test_that("Cholesky satisfies t(L)*L = A for textbook SPD matrix", {
    A <- matrix(c(4, 12, -16, 12, 37, -43, -16, -43, 98), nrow = 3)
    L <- choleskymatrix(A)
    expect_equal(t(L) %*% L, A, tolerance = 1e-10)
    expect_equal(L, chol(A), tolerance = 1e-10)
})

test_that("Cholesky satisfies t(L)*L = A for 2x2 SPD matrix", {
    A <- matrix(c(4, 2, 2, 3), nrow = 2)
    L <- choleskymatrix(A)
    expect_equal(t(L) %*% L, A, tolerance = 1e-10)
    expect_true(all(L[lower.tri(L)] == 0))
})

test_that("detmatrix matches det() for known matrices", {
    A <- matrix(c(1, 2, 3, 4), nrow = 2)
    expect_equal(detmatrix(A), det(A), tolerance = 1e-10)

    B <- matrix(c(1, 0, 0, 0, 2, 0, 0, 0, 3), nrow = 3)
    expect_equal(detmatrix(B), det(B), tolerance = 1e-10)
})

test_that("invmatrix produces actual inverse", {
    A <- matrix(c(4, 7, 2, 6), nrow = 2)
    Ainv <- invmatrix(A)
    expect_equal(A %*% Ainv, diag(2), tolerance = 1e-10)
    expect_equal(Ainv %*% A, diag(2), tolerance = 1e-10)
})

test_that("cgmmatrix solves symmetric positive-definite system", {
    A <- matrix(c(4, 1, 1, 3), nrow = 2)
    b <- c(1, 2)
    x <- cgmmatrix(A, b)
    expect_equal(as.numeric(A %*% x), b, tolerance = 1e-6)
})

test_that("gaussseidel solves diagonally dominant system", {
    A <- matrix(c(4, 1, 1, 3), nrow = 2)
    b <- c(1, 2)
    x <- gaussseidel(A, b)
    expect_equal(as.numeric(A %*% x), b, tolerance = 1e-4)
})

test_that("jacobi solves diagonally dominant system", {
    A <- matrix(c(4, 1, 1, 3), nrow = 2)
    b <- c(1, 2)
    x <- jacobi(A, b)
    expect_equal(as.numeric(A %*% x), b, tolerance = 1e-4)
})

test_that("tridiagmatrix solves tridiagonal system", {
    D <- c(2, 2, 2)
    L <- c(-1, -1)
    U <- c(-1, -1)
    b <- c(1, 0, 1)
    A <- matrix(c(2, -1, 0, -1, 2, -1, 0, -1, 2), nrow = 3, byrow = TRUE)
    x <- tridiagmatrix(L, D, U, b)
    expect_equal(as.numeric(A %*% x), b, tolerance = 1e-10)
})

test_that("iterative methods agree on well-conditioned system", {
    A <- matrix(c(10, 1, 2, 1, 10, 3, 2, 3, 10), nrow = 3)
    b <- c(1, 2, 3)
    x_gs <- gaussseidel(A, b)
    x_j <- jacobi(A, b)
    x_cg <- cgmmatrix(A, b)
    expect_equal(x_gs, x_j, tolerance = 1e-3)
    expect_equal(x_gs, x_cg, tolerance = 1e-3)
})
