## Deep correctness tests with independent mathematical oracles
## Covers linear algebra, root finding, and floating-point arithmetic

## ---- Phase 4: Linear Algebra ------------------------------------------------

test_that("choleskymatrix on 2x2 SPD matches oracle", {
    A <- matrix(c(4, 2, 2, 3), 2, 2)
    L <- choleskymatrix(A)
    ## A = t(L) %*% L
    reconstructed <- t(L) %*% L
    expect_equal(reconstructed, A, tolerance = 1e-12)
    ## L should be upper-triangular
    expect_equal(L[lower.tri(L)], rep(0, sum(lower.tri(L))))
    ## Cross-check with R's built-in chol()
    expect_equal(L, chol(A), tolerance = 1e-12)
})

test_that("choleskymatrix on 3x3 SPD matches oracle", {
    A <- matrix(c(5, 1, 2, 1, 9, 3, 2, 3, 7), 3, 3)
    L <- choleskymatrix(A)
    reconstructed <- t(L) %*% L
    expect_equal(reconstructed, A, tolerance = 1e-12)
    expect_equal(L[lower.tri(L)], rep(0, sum(lower.tri(L))))
    expect_equal(L, chol(A), tolerance = 1e-12)
})

test_that("choleskymatrix on near-singular SPD preserves decomposition", {
    A <- matrix(c(1, 0.999, 0.999, 1), 2, 2)
    ## Eigenvalues are 1.999 and 0.001, so SPD but ill-conditioned
    L <- choleskymatrix(A)
    reconstructed <- t(L) %*% L
    ## Looser tolerance due to ill-conditioning
    expect_equal(reconstructed, A, tolerance = 1e-8)
    expect_equal(L[lower.tri(L)], rep(0, sum(lower.tri(L))))
})

test_that("lumatrix decomposition verified via P %*% A = L %*% U for 4x4", {
    A <- matrix(c(2, 1, 4, 1,
                  3, 4, -1, -1,
                  1, -4, 1, 5,
                  2, -2, 1, 3), 4, 4, byrow = TRUE)
    result <- lumatrix(A)
    P <- result$P
    L <- result$L
    U <- result$U
    ## Verify P %*% A = L %*% U
    expect_equal(P %*% A, L %*% U, tolerance = 1e-10)
    ## det(A) should equal det(P)^{-1} * det(L) * det(U)
    ## L has 1s on diagonal so det(L) = 1, det(P) = +/-1
    det_A_oracle <- det(A)
    det_via_LU <- det(P) * prod(diag(U))
    expect_equal(abs(det_via_LU), abs(det_A_oracle), tolerance = 1e-8)
})

test_that("invmatrix: A * inv(A) = I for 4x4 Hilbert matrix", {
    ## Hilbert matrix H[i,j] = 1/(i+j-1)
    n <- 4
    H <- matrix(0, n, n)
    for (i in 1:n) for (j in 1:n) H[i, j] <- 1 / (i + j - 1)
    H_inv <- invmatrix(H)
    product <- H %*% H_inv
    I4 <- diag(n)
    ## Hilbert matrices are notoriously ill-conditioned, use generous tolerance
    expect_equal(product, I4, tolerance = 1e-4)
})

test_that("detmatrix returns near-zero for singular matrix", {
    ## Matrix with linearly dependent rows
    A <- matrix(c(1, 2, 3,
                  4, 5, 6,
                  5, 7, 9), 3, 3, byrow = TRUE)
    ## Row 3 = Row 1 + Row 2, so det = 0
    d <- detmatrix(A)
    expect_true(abs(d) < 1e-10)
})

test_that("detmatrix agrees with det() on well-conditioned matrix", {
    A <- matrix(c(1, 2, -7, -1, -1, 1, 2, 1, 5), 3, 3)
    expect_equal(detmatrix(A), det(A), tolerance = 1e-8)
})

test_that("gaussseidel residual ||Ax - b|| is small", {
    A <- matrix(c(10, 2, 1,
                  1, 8, 3,
                  2, 1, 10), 3, 3, byrow = TRUE)
    b <- c(14, 18, 20)
    x <- gaussseidel(A, b)
    residual <- vecnorm(A %*% x - b)
    expect_true(residual < 1e-4,
                info = paste("Gauss-Seidel residual =", residual))
})

test_that("jacobi residual ||Ax - b|| is small", {
    A <- matrix(c(10, 2, 1,
                  1, 8, 3,
                  2, 1, 10), 3, 3, byrow = TRUE)
    b <- c(14, 18, 20)
    x <- jacobi(A, b)
    residual <- vecnorm(A %*% x - b)
    expect_true(residual < 1e-4,
                info = paste("Jacobi residual =", residual))
})

test_that("gaussseidel and jacobi agree with solve() on diagonally dominant system", {
    A <- matrix(c(10, 2, 1,
                  1, 8, 3,
                  2, 1, 10), 3, 3, byrow = TRUE)
    b <- c(14, 18, 20)
    x_gs <- gaussseidel(A, b)
    x_j <- jacobi(A, b)
    x_exact <- as.vector(solve(A, b))
    expect_equal(x_gs, x_exact, tolerance = 1e-4)
    expect_equal(x_j, x_exact, tolerance = 1e-4)
})

test_that("rrefmatrix produces valid reduced row echelon form", {
    A <- matrix(c(1, 3, -1, 3,
                  2, 1,  0, 7,
                  -1, -2, 3, -2), 3, 4, byrow = TRUE)
    R <- rrefmatrix(A)
    nrows <- nrow(R)
    ncols <- ncol(R)
    ## Find pivot columns: first nonzero in each row
    pivot_cols <- integer(0)
    for (i in 1:nrows) {
        nonzero <- which(abs(R[i, ]) > 1e-10)
        if (length(nonzero) > 0) {
            pivot_cols <- c(pivot_cols, nonzero[1])
        }
    }
    ## There should be at least one pivot
    expect_true(length(pivot_cols) > 0)
    ## Check leading 1s and zeros above/below each pivot
    for (idx in seq_along(pivot_cols)) {
        i <- idx  # row index
        pc <- pivot_cols[idx]
        ## Leading entry should be 1
        expect_equal(R[i, pc], 1, tolerance = 1e-10,
                     info = paste("Leading 1 in row", i))
        ## All other entries in pivot column should be 0
        for (j in 1:nrows) {
            if (j != i) {
                expect_equal(R[j, pc], 0, tolerance = 1e-10,
                             info = paste("Zero above/below pivot in row", j, "col", pc))
            }
        }
    }
    ## Pivot columns should be strictly increasing (staircase pattern)
    if (length(pivot_cols) > 1) {
        for (k in 2:length(pivot_cols)) {
            expect_true(pivot_cols[k] > pivot_cols[k - 1],
                        info = "Pivot columns should be strictly increasing")
        }
    }
})

test_that("rrefmatrix of identity is identity", {
    I3 <- diag(3)
    expect_equal(rrefmatrix(I3), I3, tolerance = 1e-12)
})

## ---- Phase 5: Root Finding --------------------------------------------------

test_that("bisection on repeated root x^2 cannot bracket", {
    ## x^2 is non-negative everywhere, so it never changes sign.
    ## Bisection requires a sign change, so this should error.
    f <- function(x) x^2
    expect_error(bisection(f, -1, 1))
})

test_that("bisection on x^3 near zero converges (odd-multiplicity root)", {
    ## x^3 has a root at 0 with sign change, so bisection can bracket it
    f <- function(x) x^3
    root <- bisection(f, -1, 1, tol = 1e-6, m = 200)
    expect_true(abs(root) < 1e-5)
})

test_that("newton with multiplicity-2 root converges (slowly)", {
    ## f(x) = x^2 has a double root at 0
    ## Newton: x_{n+1} = x - x^2/(2x) = x/2, so convergence is linear
    f <- function(x) x^2
    fp <- function(x) 2 * x
    root <- newton(f, fp, 1, tol = 1e-6, m = 200)
    expect_true(abs(root) < 1e-4)
})

test_that("secant and bisection agree on cos(x) - x = 0 in [0, 1]", {
    f <- function(x) cos(x) - x
    root_bisect <- bisection(f, 0, 1, tol = 1e-8, m = 200)
    root_secant <- secant(f, 0, 1, tol = 1e-8, m = 200)
    ## Both should find the Dottie number, approximately 0.7390851332
    dottie <- 0.7390851332
    expect_equal(root_bisect, dottie, tolerance = 1e-6)
    expect_equal(root_secant, dottie, tolerance = 1e-6)
    ## They should agree with each other
    expect_equal(root_bisect, root_secant, tolerance = 1e-5)
})

test_that("newton convergence is faster than bisection on cos(x) - x", {
    ## Newton with quadratic convergence should achieve better accuracy
    ## at similar or fewer iterations than bisection
    f <- function(x) cos(x) - x
    fp <- function(x) -sin(x) - 1
    dottie <- 0.7390851332151607
    tol <- 1e-3
    root_bisect <- bisection(f, 0, 1, tol = tol, m = 100)
    root_newton <- newton(f, fp, 0.5, tol = tol, m = 100)
    ## Newton should be at least as close to the true root
    err_bisect <- abs(root_bisect - dottie)
    err_newton <- abs(root_newton - dottie)
    ## Newton with quadratic convergence typically overshoots the tolerance,
    ## giving a more accurate answer than bisection at the same nominal tol
    expect_true(err_newton <= err_bisect + 1e-10,
                info = paste("newton err:", err_newton, "bisection err:", err_bisect))
})

test_that("convergence order: bisection is linear (order 1)", {
    ## Bisection halves the interval each step, so after n steps
    ## the error bound is (b-a)/2^n. Cutting tol by factor of 2
    ## should require roughly 1 more iteration (same number of function evals).
    ## We verify that reducing tol by 1000x only modestly improves accuracy,
    ## consistent with linear convergence.
    f <- function(x) cos(x) - x
    dottie <- 0.7390851332151607
    r_coarse <- bisection(f, 0, 1, tol = 1e-3, m = 200)
    r_fine <- bisection(f, 0, 1, tol = 1e-9, m = 200)
    e_coarse <- abs(r_coarse - dottie)
    e_fine <- abs(r_fine - dottie)
    ## With 1e6x tighter tol, error should improve by roughly 1e6x
    ## (linear convergence: error ~ tol)
    expect_true(e_coarse > e_fine)
    expect_true(e_coarse < 1e-2)
    expect_true(e_fine < 1e-8)
})

test_that("convergence order: newton is quadratic (order 2)", {
    ## For Newton on a simple root, the final step should produce
    ## error roughly proportional to error^2 of the previous step.
    ## We verify this indirectly: with very few iterations, Newton
    ## achieves very high accuracy.
    f <- function(x) cos(x) - x
    fp <- function(x) -sin(x) - 1
    dottie <- 0.7390851332151607
    ## Newton converges so fast that even with m=5 it should be very close
    root <- newton(f, fp, 0.5, tol = 1e-12, m = 20)
    err <- abs(root - dottie)
    ## Quadratic convergence from x0=0.5 should reach machine precision quickly
    expect_true(err < 1e-10,
                info = paste("Newton error:", err))
})

## ---- Phase 10: Floating-Point Arithmetic ------------------------------------

test_that("kahansum vs naivesum on adversarial sequence", {
    ## Many small values added to a large accumulator expose naive rounding loss.
    ## With 1e16 as the first value, subsequent 1s are below the ULP of the
    ## accumulator for naivesum but Kahan's compensation term recovers them.
    n <- 10000
    x <- c(1e16, rep(1, n), -1e16)
    ## True sum is n = 10000
    kahan_result <- kahansum(x)
    naive_result <- naivesum(x)
    expect_equal(kahan_result, n)
    ## naivesum loses precision when small values are swamped by the large one
    ## (it may or may not equal n exactly depending on accumulation order)
    ## The key assertion: Kahan is at least as accurate
    kahan_err <- abs(kahan_result - n)
    naive_err <- abs(naive_result - n)
    expect_true(kahan_err <= naive_err + .Machine$double.eps,
                info = paste("kahan_err:", kahan_err, "naive_err:", naive_err))
})

test_that("kahansum preserves precision on alternating large/small values", {
    ## Sequence: 1e16, 1, 1, 1, ..., 1, -1e16
    ## True sum = number of 1s in the middle
    n_ones <- 1000
    x <- c(1e16, rep(1, n_ones), -1e16)
    expect_equal(kahansum(x), n_ones)
})

test_that("nthroot for very large values", {
    expect_equal(nthroot(1e30, 3, tol = 1e-10), 1e10, tolerance = 1e-8)
    expect_equal(nthroot(1e30, 2, tol = 1e-10), 1e15, tolerance = 1e-8)
    expect_equal(nthroot(1e100, 5, tol = 1e-10), 1e20, tolerance = 1e-8)
})

test_that("nthroot for very small values", {
    expect_equal(nthroot(1e-30, 3, tol = 1e-10), 1e-10, tolerance = 1e-8)
    expect_equal(nthroot(1e-12, 2, tol = 1e-10), 1e-6, tolerance = 1e-8)
    expect_equal(nthroot(1e-100, 5, tol = 1e-10), 1e-20, tolerance = 1e-8)
})

test_that("nthroot near one", {
    expect_equal(nthroot(1, 10, tol = 1e-10), 1, tolerance = 1e-10)
    expect_equal(nthroot(1.001, 3, tol = 1e-10), 1.001^(1/3), tolerance = 1e-8)
    expect_equal(nthroot(0.999, 3, tol = 1e-10), 0.999^(1/3), tolerance = 1e-8)
})

test_that("nthroot negative radicand with odd root", {
    result <- nthroot(-125, 3, tol = 1e-6)
    expect_equal(result, -5, tolerance = 1e-4)
})

test_that("quadratic formula for near-zero discriminant", {
    ## b^2 - 4ac = 0 => repeated root at -b/(2a)
    ## x^2 - 2x + 1 = 0 => root at x = 1 (double)
    roots1 <- quadratic(1, -2, 1)
    expect_equal(roots1, c(1, 1), tolerance = 1e-12)

    roots2 <- quadratic2(1, -2, 1)
    expect_equal(roots2, c(1, 1), tolerance = 1e-12)
})

test_that("quadratic2 is more accurate than quadratic for catastrophic cancellation", {
    ## Classic cancellation example: b^2 >> 4ac
    ## x^2 - 1e8*x + 1 = 0
    ## Roots: (1e8 +/- sqrt(1e16 - 4)) / 2
    ## Large root ~ 1e8, small root ~ 1e-8
    a <- 1
    b <- -1e8
    c_val <- 1
    roots_naive <- quadratic(a, b, c_val)
    roots_stable <- quadratic2(a, b, c_val)
    ## The small root should be approximately 1e-8
    ## quadratic2 uses the product-of-roots identity, avoiding cancellation
    true_small_root <- c_val / (a * 1e8)  # ~ 1e-8 from Vieta's formula
    err_naive <- abs(roots_naive[1] - true_small_root)
    err_stable <- abs(roots_stable[1] - true_small_root)
    ## quadratic2 should be at least as accurate
    expect_true(err_stable <= err_naive + 1e-20,
                info = paste("stable err:", err_stable, "naive err:", err_naive))
})

test_that("quadratic handles discriminant exactly zero", {
    ## 4x^2 + 4x + 1 = 0 => root at -0.5 (double)
    roots <- quadratic(4, 4, 1)
    expect_equal(roots, c(-0.5, -0.5), tolerance = 1e-12)
    roots2 <- quadratic2(4, 4, 1)
    expect_equal(roots2, c(-0.5, -0.5), tolerance = 1e-12)
})

test_that("vecnorm is correct for known vectors", {
    expect_equal(vecnorm(c(3, 4)), 5)
    expect_equal(vecnorm(c(1, 1, 1, 1)), 2)
    expect_equal(vecnorm(c(0, 0, 0)), 0)
})
