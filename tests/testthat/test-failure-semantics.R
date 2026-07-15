## Tests for changed failure semantics between develop and modernization

test_that("goldsectmin signals convergence_failure on iteration limit", {
    f <- function(x) sin(100 * x)
    expect_error(
        goldsectmin(f, 0, 6, tol = 1e-15, m = 3),
        class = "cmna_convergence_failure"
    )
    expect_error(
        goldsectmin(f, 0, 6, tol = 1e-15, m = 3),
        class = "cmna_iteration_limit"
    )
})

test_that("goldsectmax signals convergence_failure on iteration limit", {
    f <- function(x) -sin(100 * x)
    expect_error(
        goldsectmax(f, 0, 6, tol = 1e-15, m = 3),
        class = "cmna_convergence_failure"
    )
})

test_that("graddsc signals convergence_failure on iteration limit", {
    fp <- function(x) sin(x)
    expect_error(
        graddsc(fp, 100, h = 0.01, tol = 1e-15, m = 3),
        class = "cmna_convergence_failure"
    )
})

test_that("gradasc signals convergence_failure on iteration limit", {
    fp <- function(x) -sin(x)
    expect_error(
        gradasc(fp, 100, h = 0.01, tol = 1e-15, m = 3),
        class = "cmna_convergence_failure"
    )
})

test_that("gd signals convergence_failure on iteration limit", {
    fp <- function(x) sin(x)
    expect_error(
        gd(fp, 100, h = 0.01, tol = 1e-15, m = 3),
        class = "cmna_convergence_failure"
    )
})

test_that("bisection signals convergence_failure on iteration limit", {
    f <- function(x) x - 0.7
    expect_error(
        bisection(f, 0, 1, tol = 1e-15, m = 1),
        class = "cmna_convergence_failure"
    )
})

test_that("newton signals convergence_failure on iteration limit", {
    f <- function(x) x^3
    fp <- function(x) 3 * x^2
    expect_error(
        newton(f, fp, 10, tol = 1e-15, m = 2),
        class = "cmna_convergence_failure"
    )
})

test_that("secant signals convergence_failure on iteration limit", {
    f <- function(x) x^3 - x
    expect_error(
        secant(f, 0.5, 1.5, tol = 1e-15, m = 2),
        class = "cmna_convergence_failure"
    )
})

test_that("nthroot signals convergence_failure on iteration limit", {
    expect_error(
        nthroot(3, 7, tol = 1e-15, m = 1),
        class = "cmna_convergence_failure"
    )
})

test_that("nthroot signals domain error for even root of negative", {
    expect_error(
        nthroot(-4, 2),
        class = "cmna_domain_error"
    )
})

test_that("all convergence failures inherit from cmna_error", {
    err <- tryCatch(
        goldsectmin(sin, 0, 6, tol = 1e-15, m = 3),
        error = function(e) e
    )
    expect_true(inherits(err, "cmna_error"))
    expect_true(inherits(err, "error"))
    expect_true(inherits(err, "condition"))
})

test_that("invalid argument conditions inherit from cmna_error", {
    err <- tryCatch(
        bisection("not_a_function", 0, 1),
        error = function(e) e
    )
    expect_true(inherits(err, "cmna_invalid_argument"))
    expect_true(inherits(err, "cmna_error"))
})

test_that("refmatrix handles all-zero column gracefully", {
    A <- matrix(c(0, 0, 0, 0, 1, 2, 0, 3, 4), 3, 3)
    R <- refmatrix(A)
    expect_true(is.matrix(R))
    expect_equal(dim(R), dim(A))
})

test_that("rrefmatrix handles all-zero column gracefully", {
    A <- matrix(c(0, 0, 0, 0, 1, 2, 0, 3, 4), 3, 3)
    R <- rrefmatrix(A)
    expect_true(is.matrix(R))
    expect_equal(dim(R), dim(A))
})

test_that("integration rejects non-finite integrand", {
    f <- function(x) rep(NaN, length(x))
    expect_error(trap(f, 0, 1), class = "cmna_numerical_breakdown")
    expect_error(simp(f, 0, 1), class = "cmna_numerical_breakdown")
    expect_error(midpt(f, 0, 1), class = "cmna_numerical_breakdown")
})
