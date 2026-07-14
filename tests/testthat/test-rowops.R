test_that("swaprows exchanges two rows", {
    A <- matrix(1:9, 3)
    B <- swaprows(A, 1, 3)
    expect_equal(B[1, ], A[3, ])
    expect_equal(B[3, ], A[1, ])
    expect_equal(B[2, ], A[2, ])
})

test_that("scalerow multiplies a row by a constant", {
    A <- matrix(1:9, 3)
    B <- scalerow(A, 1, 3)
    expect_equal(B[1, ], 3 * A[1, ])
    expect_equal(B[2, ], A[2, ])
})

test_that("replacerow adds k times row1 to row2", {
    A <- matrix(1:9, 3)
    B <- replacerow(A, 1, 2, 2)
    expect_equal(B[2, ], A[2, ] + 2 * A[1, ])
    expect_equal(B[1, ], A[1, ])
})

test_that("swaprows twice returns original", {
    A <- matrix(1:9, 3)
    B <- swaprows(swaprows(A, 1, 2), 1, 2)
    expect_equal(B, A)
})
