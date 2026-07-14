test_that("invmatrix of identity is identity", {
    I <- diag(3)
    expect_equal(invmatrix(I), I, tolerance = 1e-10)
})

test_that("invmatrix satisfies A %*% A^-1 = I", {
    A <- matrix(c(5, 2, 1, 2, 7, 3, 3, 4, 8), 3)
    Ainv <- invmatrix(A)
    expect_equal(A %*% Ainv, diag(3), tolerance = 1e-10)
})

test_that("invmatrix agrees with solve()", {
    A <- matrix(c(1, 2, -7, -1, -1, 1, 2, 1, 5), 3)
    expect_equal(invmatrix(A), solve(A), tolerance = 1e-10)
})

test_that("invmatrix rejects non-square matrix", {
    A <- matrix(1:6, 2, 3)
    expect_error(invmatrix(A), class = "cmna_invalid_argument")
})
