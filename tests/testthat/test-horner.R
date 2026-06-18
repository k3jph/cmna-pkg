test_that("all polynomial evaluators agree on canonical values", {
    coefs <- c(5, -3, 2)
    x <- c(-2, -1, 0, 1, 2)
    expected <- c(19, 10, 5, 4, 7)

    expect_equal(naivepoly(x, coefs), expected)
    expect_equal(betterpoly(x, coefs), expected)
    expect_equal(horner(x, coefs), expected)
    expect_equal(rhorner(x, coefs), expected)
})

test_that("coefficient order is constant term first", {
    coefs <- c(5, -3, 2)

    expect_equal(horner(2, coefs), 7)
    expect_equal(naivepoly(2, coefs), 7)
})

test_that("polynomial evaluators handle constants and empty x", {
    expect_equal(horner(c(-1, 0, 1), 5), c(5, 5, 5))
    expect_equal(rhorner(c(-1, 0, 1), 5), c(5, 5, 5))
    expect_equal(naivepoly(numeric(), c(1, 2)), numeric())
    expect_equal(betterpoly(numeric(), c(1, 2)), numeric())
})

test_that("polynomial evaluators reject invalid inputs", {
    evaluators <- list(naivepoly, betterpoly, horner, rhorner)

    for (evaluate in evaluators) {
        expect_error(evaluate("x", c(1, 2)), "x must be numeric")
        expect_error(evaluate(1, character()), "coefs must be")
        expect_error(evaluate(1, numeric()), "coefs must be")
    }
})

test_that("polynomial evaluators follow ordinary R non-finite arithmetic", {
    coefs <- c(1, 2)

    expect_equal(horner(Inf, coefs), Inf)
    expect_true(is.nan(horner(NaN, coefs)))
    expect_true(is.na(horner(NA_real_, coefs)))
})

test_that("iterative and recursive Horner evaluation agree", {
    coefs <- c(-1, 0, 3, -2, 1)
    x <- seq(-2, 2, by = 0.25)

    expect_equal(horner(x, coefs), rhorner(x, coefs))
})
