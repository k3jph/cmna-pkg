test_that("LU decomposition satisfies P %*% A = L %*% U", {
    A <- matrix(c(1, 2, -7, -1, -1, 1, 2, 1, 5), 3)
    lu <- lumatrix(A)
    expect_equal(lu$P %*% A, lu$L %*% lu$U, tolerance = 1e-10)
})

test_that("LU decomposition of identity", {
    I <- diag(3)
    lu <- lumatrix(I)
    expect_equal(lu$L, I)
    expect_equal(lu$U, I)
})

test_that("LU decomposition returns correct components", {
    A <- matrix(c(5, 2, 1, 2, 7, 3, 3, 4, 8), 3)
    lu <- lumatrix(A)
    expect_true(is.list(lu))
    expect_true(all(c("P", "L", "U") %in% names(lu)))
    expect_equal(lu$P %*% A, lu$L %*% lu$U, tolerance = 1e-10)
})
