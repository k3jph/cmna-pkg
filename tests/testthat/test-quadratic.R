test_that("quadratic solvers find distinct real roots", {
    expect_equal(quadratic(1, 0, -1), c(-1, 1))
    expect_equal(quadratic2(1, 0, -1), c(-1, 1))
})

test_that("quadratic solvers return repeated roots twice", {
    expect_equal(quadratic(4, -4, 1), c(0.5, 0.5))
    expect_equal(quadratic2(4, -4, 1), c(0.5, 0.5))
})

test_that("quadratic solvers handle a zero constant term", {
    expect_equal(quadratic(1, -3, 0), c(0, 3))
    expect_equal(quadratic2(1, -3, 0), c(0, 3))
})

test_that("stable quadratic formula preserves a small root", {
    roots <- quadratic2(1, -1e8, 1)

    expect_equal(roots[[1]], 1e-8, tolerance = 1e-15)
    expect_equal(roots[[2]], 1e8, tolerance = 1e-7)
    expect_lt(abs(roots[[1]] - 1e-8),
              abs(quadratic(1, -1e8, 1)[[1]] - 1e-8))
})

test_that("quadratic solvers reject non-quadratic equations", {
    expect_error(quadratic(0, 2, 1), class = "cmna_invalid_argument")
    expect_error(quadratic2(0, 2, 1), class = "cmna_invalid_argument")
})

test_that("quadratic solvers reject non-finite coefficients", {
    expect_error(quadratic(Inf, 1, 1), class = "cmna_invalid_argument")
    expect_error(quadratic2(1, NaN, 1), class = "cmna_invalid_argument")
})

test_that("quadratic solvers reject negative discriminants", {
    expect_error(quadratic(1, 0, 1), class = "cmna_domain_error")
    expect_error(quadratic2(1, 0, 1), class = "cmna_domain_error")
})
