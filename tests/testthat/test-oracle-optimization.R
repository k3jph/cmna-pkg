## Independent oracle tests for optimization

test_that("goldsectmin finds minimum of convex quadratic", {
    f <- function(x) (x - 3)^2 + 1
    result <- goldsectmin(f, 0, 6)
    expect_equal(result, 3, tolerance = 1e-3)
    expect_equal(f(result), 1, tolerance = 1e-3)
})

test_that("goldsectmax finds maximum of concave quadratic", {
    f <- function(x) -(x - 1)^2 + 5
    result <- goldsectmax(f, -2, 4)
    expect_equal(result, 1, tolerance = 1e-3)
    expect_equal(f(result), 5, tolerance = 1e-3)
})

test_that("sa improves objective value", {
    set.seed(1)
    f <- function(x) (x - 5)^2
    x0 <- 0
    result <- sa(f, x0, temp = 1e4, rate = 1e-4)
    expect_lt(f(result), f(x0))
})

test_that("sa with multivariate finds near-optimum", {
    set.seed(42)
    f <- function(x) (x[1] - 1)^2 + (x[2] + 2)^2
    result <- sa(f, c(0, 0), temp = 1e3, rate = 1e-3)
    expect_lt(f(result), f(c(0, 0)))
})

test_that("hillclimbing finds Himmelblau minimum", {
    set.seed(1)
    result <- hillclimbing(himmelblau, c(2.5, 1.5), h = 0.5)
    expect_lt(himmelblau(result), himmelblau(c(2.5, 1.5)))
    expect_lt(himmelblau(result), 1)
})

test_that("gdls minimizes least-squares residual", {
    A <- matrix(c(1, 1, 1, 1, 1, 2, 3, 4), ncol = 2)
    b <- c(1, 2, 3, 4)
    x <- gdls(A, b, alpha = 0.01, m = 10000)
    residual <- sum((A %*% x - b)^2)
    expect_lt(residual, 1)
})

test_that("gd finds minimum direction", {
    fp <- function(x) 2 * (x - 1)
    result <- gd(fp, 0.9, h = 0.01)
    expect_equal(result, 1, tolerance = 0.1)
})

test_that("graddsc/gradasc converge to known optima", {
    fp <- function(x) 2 * x
    result <- graddsc(fp, 0.5, h = 0.01)
    expect_equal(result, 0, tolerance = 0.1)

    fp2 <- function(x) -2 * (x - 3)
    result2 <- gradasc(fp2, 2.5, h = 0.01)
    expect_equal(result2, 3, tolerance = 0.1)
})
