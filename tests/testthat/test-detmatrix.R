test_that("detmatrix of identity is 1", {
    I <- diag(3)
    expect_equal(detmatrix(I), 1)
})

test_that("detmatrix agrees with det()", {
    A <- matrix(c(1, 2, -7, -1, -1, 1, 2, 1, 5), 3)
    expect_equal(detmatrix(A), det(A), tolerance = 1e-10)
})

test_that("detmatrix of 2x2 matrix", {
    A <- matrix(c(1, 3, 2, 4), 2)
    expect_equal(detmatrix(A), 1 * 4 - 2 * 3, tolerance = 1e-10)
})

test_that("detmatrix rejects non-square matrix", {
    A <- matrix(1:6, 2, 3)
    expect_error(detmatrix(A), class = "cmna_invalid_argument")
})
