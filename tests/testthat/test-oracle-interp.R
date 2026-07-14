## Independent oracle tests for interpolation and differentiation

test_that("polyinterp recovers exact polynomial coefficients", {
    x <- c(-1, 0, 1, 2)
    coefs_true <- c(1, 0, 1, 0)  # 1 + x^2
    y <- sapply(x, function(xi) sum(coefs_true * xi^(0:3)))
    coefs <- polyinterp(x, y)
    expect_equal(coefs, coefs_true, tolerance = 1e-10)
})

test_that("horner and naivepoly agree for all evaluations", {
    coefs <- c(1, -3, 2, 5)
    x <- seq(-2, 2, by = 0.5)
    expect_equal(horner(x, coefs), naivepoly(x, coefs), tolerance = 1e-10)
    expect_equal(horner(x, coefs), betterpoly(x, coefs), tolerance = 1e-10)
    expect_equal(horner(x, coefs), rhorner(x, coefs), tolerance = 1e-10)
})

test_that("polynomial evaluation is exact for monomial", {
    coefs <- c(0, 0, 0, 1)  # x^3
    expect_equal(horner(2, coefs), 8)
    expect_equal(horner(3, coefs), 27)
    expect_equal(horner(-1, coefs), -1)
})

test_that("linterp gives correct line through two points", {
    coefs <- linterp(1, 3, 4, 9)
    expect_equal(horner(1, coefs), 3)
    expect_equal(horner(4, coefs), 9)
    m <- (9 - 3) / (4 - 1)
    expect_equal(coefs[2], m)
})

test_that("findiff approximates d/dx[sin(x)] = cos(x)", {
    for (x0 in c(0.5, pi/4, pi/2, pi)) {
        approx <- findiff(sin, x0, h = 1e-6)
        expect_equal(approx, cos(x0), tolerance = 1e-4)
    }
})

test_that("symdiff is exact for linear functions", {
    f <- function(x) 3 * x + 7
    expect_equal(symdiff(f, 5), 3, tolerance = 1e-10)
})

test_that("rdiff approximates d/dx[exp(x)] = exp(x)", {
    expect_equal(rdiff(exp, 0), 1, tolerance = 1e-8)
    expect_equal(rdiff(exp, 1), exp(1), tolerance = 1e-8)
})

test_that("findiff2 approximates d2/dx2[sin(x)] = -sin(x)", {
    for (x0 in c(pi/6, pi/3, pi/2)) {
        approx <- findiff2(sin, x0, 0.001)
        expect_equal(approx, -sin(x0), tolerance = 0.01)
    }
})

test_that("qbezier at t=0.5 is weighted average", {
    x <- c(0, 1, 2)
    y <- c(0, 2, 0)
    result <- qbezier(x, y, 0.5)
    expect_equal(result$x, 1)
    expect_equal(result$y, 1)
})

test_that("cbezier endpoint derivatives point along control polygon", {
    x <- c(0, 1, 2, 3)
    y <- c(0, 0, 0, 0)
    result <- cbezier(x, y, seq(0, 1, 0.01))
    expect_true(all(abs(result$y) < 1e-10))
})
