## Tests for interpolation methods

test_that("linterp returns correct slope and intercept", {
    coefs <- linterp(0, 0, 1, 2)
    expect_equal(coefs, c(0, 2))
    expect_equal(horner(0.5, coefs), 1)
})

test_that("polyinterp reproduces nodes via horner", {
    x <- c(0, 1, 2, 3)
    y <- c(1, 2, 5, 10)
    coefs <- polyinterp(x, y)
    for (i in seq_along(x)) {
        expect_equal(horner(x[i], coefs), y[i], tolerance = 1e-10)
    }
})

test_that("polyinterp is exact for polynomial data", {
    x <- c(-1, 0, 1, 2)
    y <- x^2 + 1
    coefs <- polyinterp(x, y)
    expect_equal(horner(0.5, coefs), 0.5^2 + 1, tolerance = 1e-10)
    expect_equal(horner(1.5, coefs), 1.5^2 + 1, tolerance = 1e-10)
})

test_that("pwiselinterp returns slopes and intercepts", {
    x <- c(0, 1, 2)
    y <- c(0, 2, 1)
    f <- pwiselinterp(x, y)
    expect_true(is.list(f))
    expect_equal(length(f$m), 2)
    expect_equal(length(f$b), 2)
    expect_equal(f$m[1], 2)
    expect_equal(f$b[1], 0)
})

test_that("cubicspline returns coefficient lists", {
    x <- c(0, 1, 2, 3)
    y <- c(0, 1, 0, 1)
    f <- cubicspline(x, y)
    expect_true(is.list(f))
    expect_equal(length(f$a), 3)
    expect_equal(f$a, y[1:3])
})

test_that("bilinear interpolates within rectangle", {
    x <- c(0, 1)
    y <- c(0, 1)
    z <- matrix(c(0, 1, 1, 2), nrow = 2)
    result <- bilinear(x, y, z, 0.5, 0.5)
    expect_true(is.numeric(result))
    expect_length(result, 1)
})

test_that("resizeImageNN produces correct dimensions", {
    m <- array(1:48, dim = c(4, 4, 3))
    result <- resizeImageNN(m, 8, 8)
    expect_equal(dim(result)[1], 8)
    expect_equal(dim(result)[2], 8)
    expect_equal(dim(result)[3], 3)
})

test_that("resizeImageBL produces correct dimensions", {
    m <- array(1:48, dim = c(4, 4, 3))
    result <- resizeImageBL(m, 8, 8)
    expect_equal(dim(result)[1], 8)
    expect_equal(dim(result)[2], 8)
    expect_equal(dim(result)[3], 3)
})

test_that("resizeImageNN identity resize preserves values", {
    m <- array(1:12, dim = c(2, 2, 3))
    result <- resizeImageNN(m, 2, 2)
    expect_equal(result, m)
})

test_that("qbezier starts and ends at control points", {
    x <- c(0, 1, 2)
    y <- c(0, 3, 0)
    result <- qbezier(x, y, c(0, 1))
    expect_equal(result$x[1], 0)
    expect_equal(result$y[1], 0)
    expect_equal(result$x[2], 2)
    expect_equal(result$y[2], 0)
})

test_that("cbezier starts and ends at control points", {
    x <- c(0, 1, 2, 3)
    y <- c(0, 3, 3, 0)
    result <- cbezier(x, y, c(0, 1))
    expect_equal(result$x[1], 0)
    expect_equal(result$y[1], 0)
    expect_equal(result$x[2], 3)
    expect_equal(result$y[2], 0)
})
