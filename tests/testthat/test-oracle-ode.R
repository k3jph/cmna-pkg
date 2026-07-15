## Independent oracle tests for ODE solvers
## Using y' = y, y(0) = 1, exact solution y(t) = exp(t)

test_that("rungekutta4 convergence order is approximately 4", {
    f <- function(x, y) y
    exact <- exp(1)
    err_h1 <- abs(rungekutta4(f, 0, 1, 0.1, 10)$y[11] - exact)
    err_h2 <- abs(rungekutta4(f, 0, 1, 0.05, 20)$y[21] - exact)
    ratio <- log2(err_h1 / err_h2)
    expect_gt(ratio, 3.5)
})

test_that("euler convergence order is approximately 1", {
    f <- function(x, y) y
    exact <- exp(1)
    err_h1 <- abs(euler(f, 0, 1, 0.01, 100)$y[101] - exact)
    err_h2 <- abs(euler(f, 0, 1, 0.005, 200)$y[201] - exact)
    ratio <- log2(err_h1 / err_h2)
    expect_gt(ratio, 0.8)
    expect_lt(ratio, 1.5)
})

test_that("midptivp convergence order is approximately 2", {
    f <- function(x, y) y
    exact <- exp(1)
    err_h1 <- abs(midptivp(f, 0, 1, 0.01, 100)$y[101] - exact)
    err_h2 <- abs(midptivp(f, 0, 1, 0.005, 200)$y[201] - exact)
    ratio <- log2(err_h1 / err_h2)
    expect_gt(ratio, 1.5)
})

test_that("euler solves y' = -2xy, y(0) = 1 (Gaussian decay)", {
    f <- function(x, y) -2 * x * y
    result <- euler(f, 0, 1, 0.001, 1000)
    exact <- exp(-1)
    expect_equal(result$y[1001], exact, tolerance = 0.01)
})

test_that("rungekutta4 solves y' = cos(x), y(0) = 0", {
    f <- function(x, y) cos(x)
    result <- rungekutta4(f, 0, 0, 0.01, 100)
    exact <- sin(1)
    expect_equal(result$y[101], exact, tolerance = 1e-8)
})

test_that("rungekutta4 achieves RK4-level accuracy on y'=-y^2", {
    f <- function(x, y) -y^2
    result <- rungekutta4(f, 0, 1, 0.001, 1000)
    exact <- 1 / 2
    expect_equal(result$y[1001], exact, tolerance = 1e-12)
})

test_that("IVP solvers return correct structure", {
    f <- function(x, y) y
    result <- euler(f, 0, 1, 0.1, 5)
    expect_equal(nrow(result), 6)
    expect_true(all(c("x", "y") %in% names(result)))
    expect_equal(result$x[1], 0)
    expect_equal(result$y[1], 1)
    expect_equal(result$x[6], 0.5)
})

test_that("eulersys preserves named components", {
    f <- function(x, y) {
        c(y1 = y[2], y2 = -y[1])
    }
    result <- eulersys(f, 0, c(y1 = 1, y2 = 0), 0.01, 100)
    expect_true("y1" %in% names(result))
    expect_true("y2" %in% names(result))
    expect_equal(result$x[1], 0)
})

test_that("heat equation returns valid result", {
    x <- seq(0, 1, 0.05)
    u <- sin(x * pi)
    result <- heat(u, 0.1, 0.05, 0.001, 25)
    expect_true(is.numeric(result))
    expect_true(all(is.finite(result)))
})
