test_that("polyinterp recovers a quadratic", {
    x <- c(1, 2, 3)
    y <- x^2 + 5 * x - 3
    coefs <- polyinterp(x, y)
    for (xi in x) {
        expect_equal(horner(xi, coefs), xi^2 + 5 * xi - 3, tolerance = 1e-10)
    }
})

test_that("polyinterp interpolates the supplied nodes", {
    x <- c(-1, 0, 1, 2)
    y <- c(1, 0, 1, 4)
    coefs <- polyinterp(x, y)
    for (i in seq_along(x)) {
        expect_equal(horner(x[i], coefs), y[i], tolerance = 1e-10)
    }
})

test_that("polyinterp rejects mismatched lengths", {
    expect_error(polyinterp(1:3, 1:2))
})
