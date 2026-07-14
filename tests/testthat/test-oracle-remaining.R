## Independent oracle tests for the 15 remaining exported functions

## --- adamsbashforth ---

test_that("adamsbashforth solves y'=y with reasonable accuracy", {
    f <- function(x, y) y
    result <- adamsbashforth(f, 0, 1, 0.01, 100)
    exact <- exp(1)
    expect_equal(result$y[101], exact, tolerance = 0.01)
})

test_that("adamsbashforth solves y'=cos(x), y(0)=0", {
    f <- function(x, y) cos(x)
    result <- adamsbashforth(f, 0, 0, 0.01, 100)
    exact <- sin(1)
    expect_equal(result$y[101], exact, tolerance = 0.01)
})

test_that("adamsbashforth returns correct structure", {
    f <- function(x, y) y
    result <- adamsbashforth(f, 0, 1, 0.1, 5)
    expect_true(is.data.frame(result))
    expect_true(all(c("x", "y") %in% names(result)))
    expect_equal(nrow(result), 6)
    expect_equal(result$x[1], 0)
    expect_equal(result$y[1], 1)
})

## --- bilinear ---

test_that("bilinear interpolates constant surface exactly", {
    x <- c(0, 1)
    y <- c(0, 1)
    z <- matrix(5, 2, 2)
    expect_equal(bilinear(x, y, z, 0.5, 0.5), 5)
    expect_equal(bilinear(x, y, z, 0.1, 0.9), 5)
})

test_that("bilinear reproduces grid corners", {
    x <- c(0, 1)
    y <- c(0, 1)
    z <- matrix(c(0, 1, 2, 3), 2, 2)
    expect_equal(bilinear(x, y, z, 0, 0), z[1, 1])
    expect_equal(bilinear(x, y, z, 1, 0), z[1, 2])
    expect_equal(bilinear(x, y, z, 0, 1), z[2, 1])
    expect_equal(bilinear(x, y, z, 1, 1), z[2, 2])
    expect_equal(bilinear(x, y, z, 0.5, 0.5), mean(z))
})

test_that("bilinear reproduces grid values", {
    x <- c(0, 1)
    y <- c(0, 1)
    z <- matrix(c(10, 20, 30, 40), 2, 2)
    expect_equal(bilinear(x, y, z, 0, 0), 10)
    expect_equal(bilinear(x, y, z, 1, 1), 40)
})

## --- bvpexample / bvpexample10 ---

test_that("bvpexample is a valid shooting residual", {
    r0 <- bvpexample(0)
    r1 <- bvpexample(1)
    expect_true(is.numeric(r0))
    expect_true(is.finite(r0))
    expect_true(r0 * r1 < 0 || abs(r0) < 1 || abs(r1) < 1)
})

test_that("bvpexample has a root (shooting method succeeds)", {
    root <- bisection(bvpexample, -2, 2, tol = 1e-3)
    expect_equal(bvpexample(root), 0, tolerance = 0.01)
})

test_that("bvpexample10 has a root consistent with bvpexample", {
    root_fine <- bisection(bvpexample, -2, 2, tol = 1e-3)
    root_coarse <- bisection(bvpexample10, -2, 2, tol = 1e-3)
    expect_equal(root_coarse, root_fine, tolerance = 0.1)
})

## --- cubicspline ---

test_that("cubicspline reproduces data points", {
    x <- c(1, 2, 3, 4)
    y <- c(1, 4, 9, 16)
    cs <- cubicspline(x, y)
    for (i in seq_along(x)) {
        xi <- x[i]
        j <- min(i, length(x) - 1)
        dx <- xi - x[j]
        val <- cs$a[j] + cs$b[j]*dx + cs$c[j]*dx^2 + cs$d[j]*dx^3
        expect_equal(val, y[i], tolerance = 1e-10)
    }
})

test_that("cubicspline is exact for linear data", {
    x <- 1:5
    y <- 2 * x + 3
    cs <- cubicspline(x, y)
    expect_equal(cs$b, rep(2, 4), tolerance = 1e-10)
    expect_true(all(abs(cs$c) < 1e-10))
    expect_true(all(abs(cs$d) < 1e-10))
})

test_that("cubicspline returns correct structure", {
    cs <- cubicspline(1:4, c(1, 4, 9, 16))
    expect_true(is.list(cs))
    expect_equal(length(cs$a), 3)
    expect_equal(length(cs$b), 3)
    expect_equal(length(cs$c), 3)
    expect_equal(length(cs$d), 3)
})

## --- gauss.hermite ---

test_that("gauss.hermite integrates exp(-x^2) to sqrt(pi)", {
    result <- gauss.hermite(function(x) rep(1, length(x)), m = 5)
    expect_equal(result, sqrt(pi), tolerance = 1e-10)
})

test_that("gauss.hermite integrates x^2*exp(-x^2) to sqrt(pi)/2", {
    result <- gauss.hermite(function(x) x^2, m = 5)
    expect_equal(result, sqrt(pi)/2, tolerance = 1e-10)
})

## --- gauss.laguerre ---

test_that("gauss.laguerre integrates exp(-x) over [0,inf) to 1", {
    result <- gauss.laguerre(function(x) rep(1, length(x)), m = 5)
    expect_equal(result, 1, tolerance = 1e-10)
})

test_that("gauss.laguerre integrates x*exp(-x) to 1 (Gamma(2))", {
    result <- gauss.laguerre(function(x) x, m = 5)
    expect_equal(result, 1, tolerance = 1e-10)
})

## --- gaussint ---

test_that("gaussint with 2-point Gauss-Legendre nodes is exact for cubics", {
    x <- c(-1/sqrt(3), 1/sqrt(3))
    w <- c(1, 1)
    expect_equal(gaussint(function(x) x^2, x, w), 2/3, tolerance = 1e-10)
    expect_equal(gaussint(function(x) x^3, x, w), 0, tolerance = 1e-10)
})

test_that("gaussint integrates constant to 2 on [-1,1]", {
    x <- c(-1/sqrt(3), 1/sqrt(3))
    w <- c(1, 1)
    expect_equal(gaussint(function(x) rep(1, length(x)), x, w), 2, tolerance = 1e-10)
})

## --- giniquintile ---

test_that("giniquintile perfect equality gives Gini = 0", {
    expect_equal(giniquintile(c(20, 20, 20, 20)), 0, tolerance = 1e-10)
})

test_that("giniquintile maximum concentration gives positive Gini", {
    result <- giniquintile(c(0, 0, 0, 100))
    expect_gt(result, 0.3)
    expect_lt(result, 0.5)
})

test_that("giniquintile US 2005 data gives known value", {
    us2005 <- c(3.4, 8.6, 14.6, 23.0)
    result <- giniquintile(us2005)
    expect_gt(result, 0.35)
    expect_lt(result, 0.50)
})

## --- nn ---

test_that("nn returns nearest neighbor value", {
    p <- matrix(c(0, 0, 1, 0, 0, 1), ncol = 2, byrow = TRUE)
    y <- c(10, 20, 30)
    q <- matrix(c(0.9, 0.1), ncol = 2)
    expect_equal(nn(p, y, q), 20)
})

test_that("nn returns exact match", {
    p <- matrix(c(1, 2, 3, 4, 5, 6), ncol = 2, byrow = TRUE)
    y <- c(100, 200, 300)
    q <- matrix(c(3, 4), ncol = 2)
    expect_equal(nn(p, y, q), 200)
})

## --- pwiselinterp ---

test_that("pwiselinterp reproduces data points", {
    x <- c(1, 3, 5, 7)
    y <- c(2, 6, 10, 14)
    pw <- pwiselinterp(x, y)
    for (i in 1:(length(x) - 1)) {
        val <- pw$m[i] * x[i] + pw$b[i]
        expect_equal(val, y[i], tolerance = 1e-10)
        val2 <- pw$m[i] * x[i+1] + pw$b[i]
        expect_equal(val2, y[i+1], tolerance = 1e-10)
    }
})

test_that("pwiselinterp is exact for linear function", {
    x <- 1:5
    y <- 3 * x + 1
    pw <- pwiselinterp(x, y)
    expect_equal(pw$m, rep(3, 4), tolerance = 1e-10)
})

test_that("pwiselinterp returns correct structure", {
    pw <- pwiselinterp(1:4, c(2, 5, 10, 17))
    expect_true(is.list(pw))
    expect_equal(length(pw$m), 3)
    expect_equal(length(pw$b), 3)
})

## --- resizeImageNN ---

test_that("resizeImageNN preserves constant image", {
    img <- array(7, dim = c(4, 4, 3))
    result <- resizeImageNN(img, 2, 2)
    expect_equal(dim(result), c(2, 2, 3))
    expect_true(all(result == 7))
})

test_that("resizeImageNN produces correct dimensions", {
    img <- array(1, dim = c(10, 10, 1))
    result <- resizeImageNN(img, 5, 3)
    expect_equal(dim(result), c(3, 5, 1))
})

## --- resizeImageBL ---

test_that("resizeImageBL preserves constant image", {
    img <- array(42, dim = c(4, 4, 3))
    result <- resizeImageBL(img, 2, 2)
    expect_equal(dim(result), c(2, 2, 3))
    expect_true(all(abs(result - 42) < 1e-10))
})

test_that("resizeImageBL produces correct dimensions", {
    img <- array(1, dim = c(10, 10, 1))
    result <- resizeImageBL(img, 5, 3)
    expect_equal(dim(result), c(3, 5, 1))
})

## --- tspsa ---

test_that("tspsa returns valid permutation", {
    set.seed(42)
    coords <- matrix(c(0,0, 1,0, 1,1, 0,1), ncol=2, byrow=TRUE)
    result <- tspsa(coords, temp = 100, rate = 0.01)
    expect_true(is.list(result))
    expect_equal(sort(result$order), 1:4)
    expect_true(is.numeric(result$distance))
    expect_gt(result$distance, 0)
})

test_that("tspsa distance is sum of tour edges", {
    set.seed(42)
    coords <- matrix(c(0,0, 1,0, 0,1), ncol=2, byrow=TRUE)
    result <- tspsa(coords, temp = 10, rate = 0.01)
    ord <- result$order
    tour_dist <- sum(sapply(seq_along(ord), function(i) {
        j <- if (i < length(ord)) i + 1 else 1
        vecnorm(coords[ord[i],] - coords[ord[j],])
    }))
    expect_equal(result$distance, tour_dist, tolerance = 1e-10)
})

## --- wave ---

test_that("wave equation returns finite values", {
    x <- seq(0, 1, 0.05)
    u <- sin(x * pi)
    result <- wave(u, 0.5, 0.05, 0.01, 10)
    expect_true(is.numeric(result))
    expect_true(all(is.finite(result)))
})

test_that("wave with zero initial condition stays zero", {
    n <- 21
    u <- rep(0, n)
    result <- wave(u, 0.5, 0.05, 0.01, 5)
    expect_true(is.matrix(result))
    expect_equal(nrow(result), 6)
    expect_true(all(abs(result) < 1e-10))
})

test_that("wave preserves boundary conditions at all timesteps", {
    x <- seq(0, 1, 0.05)
    u <- sin(x * pi)
    result <- wave(u, 0.5, 0.05, 0.01, 10)
    expect_true(all(abs(result[, 1]) < 1e-10))
    expect_true(all(abs(result[, ncol(result)]) < 1e-10))
})
