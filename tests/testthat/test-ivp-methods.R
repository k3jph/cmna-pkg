## Tests for IVP solvers: euler, midptivp, rungekutta4, adamsbashforth

test_that("euler solves y' = y with known solution", {
    f <- function(x, y) y
    result <- euler(f, 0, 1, 0.001, 1000)
    expect_equal(nrow(result), 1001)
    expect_equal(result$x[1], 0)
    expect_equal(result$x[1001], 1, tolerance = 1e-10)
    expect_equal(result$y[1001], exp(1), tolerance = 0.01)
})

test_that("midptivp solves y' = y with better accuracy than euler", {
    f <- function(x, y) y
    euler_result <- euler(f, 0, 1, 0.01, 100)
    midpt_result <- midptivp(f, 0, 1, 0.01, 100)
    euler_err <- abs(euler_result$y[101] - exp(1))
    midpt_err <- abs(midpt_result$y[101] - exp(1))
    expect_lt(midpt_err, euler_err)
})

test_that("rungekutta4 solves y' = y with high accuracy", {
    f <- function(x, y) y
    result <- rungekutta4(f, 0, 1, 0.1, 10)
    expect_equal(result$y[11], exp(1), tolerance = 1e-6)
})

test_that("adamsbashforth solves y' = y", {
    f <- function(x, y) y
    result <- adamsbashforth(f, 0, 1, 0.01, 100)
    expect_equal(result$y[101], exp(1), tolerance = 0.01)
})

test_that("IVP methods agree on y' = -y", {
    f <- function(x, y) -y
    h <- 0.01
    n <- 100
    exact <- exp(-1)
    r_euler <- euler(f, 0, 1, h, n)
    r_midpt <- midptivp(f, 0, 1, h, n)
    r_rk4 <- rungekutta4(f, 0, 1, h, n)
    r_ab <- adamsbashforth(f, 0, 1, h, n)
    expect_equal(r_euler$y[n + 1], exact, tolerance = 0.02)
    expect_equal(r_midpt$y[n + 1], exact, tolerance = 0.01)
    expect_equal(r_rk4$y[n + 1], exact, tolerance = 1e-6)
    expect_equal(r_ab$y[n + 1], exact, tolerance = 0.01)
})

test_that("higher-order methods are more accurate", {
    f <- function(x, y) y
    h <- 0.1
    n <- 10
    exact <- exp(1)
    err_euler <- abs(euler(f, 0, 1, h, n)$y[n + 1] - exact)
    err_rk4 <- abs(rungekutta4(f, 0, 1, h, n)$y[n + 1] - exact)
    expect_lt(err_rk4, err_euler)
})

test_that("eulersys solves a system", {
    f <- function(x, y) y / (2 * x + 1)
    result <- eulersys(f, 0, c(y1 = 1), 0.01, 100)
    expect_true("x" %in% names(result))
    expect_true("y1" %in% names(result))
    expect_equal(nrow(result), 101)
})

test_that("bvpexample returns residual", {
    r <- bvpexample(0)
    expect_true(is.numeric(r))
    expect_length(r, 1)
})

test_that("bvpexample10 returns residual", {
    r <- bvpexample10(0)
    expect_true(is.numeric(r))
    expect_length(r, 1)
})
