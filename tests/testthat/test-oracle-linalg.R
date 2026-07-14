## Independent mathematical oracle tests for linear algebra
## Each test uses an independent reference (base R, exact formula, or invariant)

test_that("detmatrix matches base R det() for various matrices", {
    set.seed(1)
    # 1x1
    A1 <- matrix(7, 1, 1)
    expect_equal(detmatrix(A1), 7)

    # 2x2: ad - bc
    A2 <- matrix(c(3, 8, 4, 6), 2)
    expect_equal(detmatrix(A2), 3*6 - 4*8)

    # 3x3 identity
    expect_equal(detmatrix(diag(3)), 1)

    # 3x3 random
    A3 <- matrix(c(1, 2, 3, 0, 4, 5, 1, 0, 6), 3, byrow = TRUE)
    expect_equal(detmatrix(A3), det(A3), tolerance = 1e-10)
})

test_that("invmatrix satisfies A * A^{-1} = I and matches solve()", {
    A <- matrix(c(1, 2, 3, 0, 1, 4, 5, 6, 0), 3, byrow = TRUE)
    Ainv <- invmatrix(A)
    I3 <- diag(3)
    expect_equal(A %*% Ainv, I3, tolerance = 1e-10)
    expect_equal(Ainv %*% A, I3, tolerance = 1e-10)
    expect_equal(Ainv, solve(A), tolerance = 1e-10)
})

test_that("refmatrix produces row-echelon form", {
    A <- matrix(c(2, 1, -1, -3, -1, 2, -2, 1, 2), 3, byrow = TRUE)
    R <- refmatrix(A)
    for (i in 2:nrow(R))
        for (j in 1:(i-1))
            expect_equal(R[i, j], 0, tolerance = 1e-10)
})

test_that("solvematrix matches solve() for known system", {
    A <- matrix(c(2, 1, -1, -3, -1, 2, -2, 1, 2), 3, byrow = TRUE)
    b <- c(8, -11, -3)
    x <- solvematrix(A, b)
    x_ref <- as.numeric(solve(A, b))
    expect_equal(x, x_ref, tolerance = 1e-10)
    expect_equal(as.numeric(A %*% x), b, tolerance = 1e-10)
})

test_that("lumatrix: PA = LU for matrix requiring pivoting", {
    A <- matrix(c(0, 2, 1, 1, 1, 0, 2, 0, 1), 3, byrow = TRUE)
    lu <- lumatrix(A)
    expect_equal(lu$P %*% A, lu$L %*% lu$U, tolerance = 1e-10)
})

test_that("choleskymatrix matches chol() for Hilbert matrix", {
    n <- 4
    H <- outer(1:n, 1:n, function(i, j) 1/(i + j - 1))
    L <- choleskymatrix(H)
    L_ref <- chol(H)
    expect_equal(L, L_ref, tolerance = 1e-10)
    expect_equal(t(L) %*% L, H, tolerance = 1e-10)
})

test_that("cgmmatrix solution satisfies Ax=b residual", {
    A <- matrix(c(4, 1, 1, 3), 2)
    b <- c(1, 2)
    x <- cgmmatrix(A, b)
    residual <- as.numeric(A %*% x - b)
    expect_equal(residual, c(0, 0), tolerance = 1e-6)
    x_ref <- as.numeric(solve(A, b))
    expect_equal(x, x_ref, tolerance = 1e-6)
})

test_that("gaussseidel/jacobi converge to solve() solution", {
    A <- matrix(c(10, -1, 2, -1, 11, -1, 2, -1, 10), 3, byrow = TRUE)
    b <- c(6, 25, -11)
    x_ref <- as.numeric(solve(A, b))
    x_gs <- gaussseidel(A, b)
    x_j <- jacobi(A, b)
    expect_equal(x_gs, x_ref, tolerance = 1e-4)
    expect_equal(x_j, x_ref, tolerance = 1e-4)
})

test_that("vecnorm computes Euclidean norm", {
    x <- c(3, -4)
    expect_equal(vecnorm(x), 5)

    y <- c(1, 2, 3)
    expect_equal(vecnorm(y), sqrt(14))

    expect_equal(vecnorm(c(1, 0, 0)), 1)
    expect_equal(vecnorm(c(0, 0, 0)), 0)
})

test_that("tridiagmatrix matches solve() for tridiagonal system", {
    D <- c(4, 4, 4)
    L <- c(1, 1)
    U <- c(1, 1)
    b <- c(1, 2, 3)
    x <- tridiagmatrix(L, D, U, b)
    A <- diag(D)
    A[2,1] <- L[1]; A[3,2] <- L[2]
    A[1,2] <- U[1]; A[2,3] <- U[2]
    x_ref <- as.numeric(solve(A, b))
    expect_equal(x, x_ref, tolerance = 1e-10)
})

test_that("row operations satisfy expected identities", {
    A <- matrix(1:9, 3, 3)
    B <- swaprows(A, 1, 3)
    expect_equal(B[1, ], A[3, ])
    expect_equal(B[3, ], A[1, ])
    expect_equal(B[2, ], A[2, ])

    C <- scalerow(A, 2, 3)
    expect_equal(C[2, ], 3 * A[2, ])

    D <- replacerow(A, 1, 2, 2)
    expect_equal(D[2, ], A[2, ] + 2 * A[1, ])
})
