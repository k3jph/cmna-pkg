test_that("jacobi solves a diagonally dominant system", {
    A <- matrix(c(5, 2, 1, 2, 7, 3, 3, 4, 8), 3)
    b <- c(40, 39, 55)
    x <- jacobi(A, b)
    expect_equal(as.vector(A %*% x), b, tolerance = 1e-5)
})

test_that("gaussseidel solves a diagonally dominant system", {
    A <- matrix(c(5, 2, 1, 2, 7, 3, 3, 4, 8), 3)
    b <- c(40, 39, 55)
    x <- gaussseidel(A, b)
    expect_equal(as.vector(A %*% x), b, tolerance = 1e-5)
})

test_that("cgmmatrix solves a symmetric positive definite system", {
    A <- matrix(c(5, 1, 2, 1, 9, 3, 2, 3, 7), 3)
    b <- c(1, 2, 3)
    x <- cgmmatrix(A, b)
    expect_equal(as.vector(A %*% x), b, tolerance = 1e-5)
})

test_that("jacobi and gaussseidel agree for a well-conditioned system", {
    A <- matrix(c(10, 1, 1, 1, 10, 1, 1, 1, 10), 3)
    b <- c(12, 12, 12)
    xj <- jacobi(A, b)
    xgs <- gaussseidel(A, b)
    expect_equal(xj, xgs, tolerance = 1e-5)
})

test_that("identity system returns b", {
    I <- diag(3)
    b <- c(1, 2, 3)
    x <- jacobi(I, b)
    expect_equal(x, b, tolerance = 1e-5)
})
