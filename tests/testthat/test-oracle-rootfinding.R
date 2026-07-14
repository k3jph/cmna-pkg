## Independent mathematical oracle tests for root finding

test_that("bisection finds exact root of x^2 - 4", {
    f <- function(x) x^2 - 4
    root <- bisection(f, 0, 3, tol = 1e-8)
    expect_equal(root, 2, tolerance = 1e-6)
    expect_equal(f(root), 0, tolerance = 1e-5)
})

test_that("bisection finds irrational root of x^2 - 2", {
    f <- function(x) x^2 - 2
    root <- bisection(f, 1, 2, tol = 1e-8)
    expect_equal(root, sqrt(2), tolerance = 1e-6)
    expect_equal(f(root), 0, tolerance = 1e-5)
})

test_that("newton finds sqrt(2) via x^2 - 2", {
    f <- function(x) x^2 - 2
    fp <- function(x) 2 * x
    root <- newton(f, fp, 1.5, tol = 1e-10)
    expect_equal(root, sqrt(2), tolerance = 1e-10)
})

test_that("newton finds cube root via x^3 - 8", {
    f <- function(x) x^3 - 8
    fp <- function(x) 3 * x^2
    root <- newton(f, fp, 3, tol = 1e-10)
    expect_equal(root, 2, tolerance = 1e-10)
})

test_that("secant finds root of sin(x) near pi", {
    root <- secant(sin, 3, 3.5, tol = 1e-8)
    expect_equal(root, pi, tolerance = 1e-6)
    expect_equal(sin(root), 0, tolerance = 1e-6)
})

test_that("all root finders agree on cos(x) = 0", {
    f <- function(x) cos(x)
    fp <- function(x) -sin(x)
    r_bisect <- bisection(f, 1, 2, tol = 1e-8)
    r_newton <- newton(f, fp, 1.5, tol = 1e-10)
    r_secant <- secant(f, 1.0, 2.0, tol = 1e-8)
    expect_equal(r_bisect, pi/2, tolerance = 1e-6)
    expect_equal(r_newton, pi/2, tolerance = 1e-10)
    expect_equal(r_secant, pi/2, tolerance = 1e-6)
})

test_that("bisection handles root at endpoint", {
    f <- function(x) x
    root <- bisection(f, 0, 1)
    expect_equal(root, 0, tolerance = 1e-10)
})

test_that("newton converges at initial guess if already a root", {
    f <- function(x) x^2
    fp <- function(x) 2*x
    root <- newton(f, fp, 0)
    expect_equal(root, 0, tolerance = 1e-10)
})

test_that("bisection rejects invalid bracket (same sign)", {
    f <- function(x) x^2 + 1
    expect_error(bisection(f, 0, 1))
})

test_that("residuals are small for all methods on exp(x) - 2", {
    f <- function(x) exp(x) - 2
    fp <- function(x) exp(x)
    r1 <- bisection(f, 0, 1, tol = 1e-8)
    r2 <- newton(f, fp, 1, tol = 1e-10)
    r3 <- secant(f, 0.5, 1.0, tol = 1e-8)
    expect_true(abs(f(r1)) < 1e-6)
    expect_true(abs(f(r2)) < 1e-10)
    expect_true(abs(f(r3)) < 1e-6)
})
