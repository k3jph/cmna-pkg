test_that("euler solves y' = y with correct exponential growth", {
    f <- function(x, y) y
    result <- euler(f, 0, 1, 0.001, 1000)
    expect_equal(tail(result$y, 1), exp(1), tolerance = 0.01)
})

test_that("rungekutta4 is more accurate than euler", {
    f <- function(x, y) y
    e_euler <- euler(f, 0, 1, 0.01, 100)
    e_rk4 <- rungekutta4(f, 0, 1, 0.01, 100)
    err_euler <- abs(tail(e_euler$y, 1) - exp(1))
    err_rk4 <- abs(tail(e_rk4$y, 1) - exp(1))
    expect_lt(err_rk4, err_euler)
})

test_that("rungekutta4 solves y' = y accurately", {
    f <- function(x, y) y
    result <- rungekutta4(f, 0, 1, 0.01, 100)
    expect_equal(tail(result$y, 1), exp(1), tolerance = 1e-8)
})

test_that("midptivp solves y' = y better than euler", {
    f <- function(x, y) y
    e_euler <- euler(f, 0, 1, 0.01, 100)
    e_midpt <- midptivp(f, 0, 1, 0.01, 100)
    err_euler <- abs(tail(e_euler$y, 1) - exp(1))
    err_midpt <- abs(tail(e_midpt$y, 1) - exp(1))
    expect_lt(err_midpt, err_euler)
})

test_that("IVP solvers return data frames with x and y", {
    f <- function(x, y) y
    result <- euler(f, 0, 1, 0.1, 10)
    expect_true(is.data.frame(result))
    expect_true(all(c("x", "y") %in% names(result)))
    expect_equal(nrow(result), 11)
})

test_that("adamsbashforth solves y' = y", {
    f <- function(x, y) y
    result <- adamsbashforth(f, 0, 1, 0.01, 100)
    expect_equal(tail(result$y, 1), exp(1), tolerance = 0.01)
})
