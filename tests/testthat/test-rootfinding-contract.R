test_that("root-finding methods agree on the canonical square-root case", {
    f <- function(x) x^2 - 2
    fp <- function(x) 2 * x

    bisection_root <- bisection(f, 1, 2, tol = 1e-10)
    newton_root <- newton(f, fp, 1, tol = 1e-10)
    secant_root <- secant(f, 1, 2, tol = 1e-10)

    expect_equal(bisection_root, sqrt(2), tolerance = 1e-10)
    expect_equal(newton_root, sqrt(2), tolerance = 1e-10)
    expect_equal(secant_root, sqrt(2), tolerance = 1e-10)
    expect_equal(bisection_root, newton_root, tolerance = 1e-9)
    expect_equal(newton_root, secant_root, tolerance = 1e-9)
})

test_that("root-finding failures inherit from the CMNA base condition", {
    expect_error(
        bisection(identity, 0, Inf),
        class = "cmna_error"
    )
    expect_error(
        newton(function(x) x^2 + 1, function(x) 0, 1),
        class = "cmna_error"
    )
    expect_error(
        secant(function(x) x^2 + 1, -1, 1),
        class = "cmna_error"
    )
})
