## Tests to fill coverage gaps

## nn.R - nearest neighbor
test_that("nn finds nearest neighbor", {
    p <- matrix(c(0, 0, 1, 0, 0, 1, 1, 1), ncol = 2, byrow = TRUE)
    y <- c(10, 20, 30, 40)
    q <- matrix(c(0.1, 0.1), ncol = 2)
    expect_equal(nn(p, y, q), 10)
    q2 <- matrix(c(0.9, 0.9), ncol = 2)
    expect_equal(nn(p, y, q2), 40)
})

test_that("nn rejects mismatched columns", {
    p <- matrix(1:6, ncol = 2)
    y <- c(1, 2, 3)
    q <- matrix(1:3, ncol = 3)
    expect_error(nn(p, y, q), class = "cmna_invalid_argument")
})

## sa.R - simulated annealing
test_that("sa finds minimum of simple function", {
    set.seed(42)
    f <- function(x) (x - 3)^2
    result <- sa(f, 0, temp = 1e3, rate = 1e-3)
    expect_equal(result, 3, tolerance = 1)
})

test_that("sa rejects invalid inputs", {
    expect_error(sa("not_a_function", 0), class = "cmna_invalid_argument")
    f <- function(x) x^2
    expect_error(sa(f, "abc"), class = "cmna_invalid_argument")
    expect_error(sa(f, 0, temp = -1), class = "cmna_invalid_argument")
    expect_error(sa(f, 0, rate = -1), class = "cmna_invalid_argument")
})

test_that("tspsa returns order and distance", {
    set.seed(42)
    pts <- matrix(c(0, 0, 1, 0, 1, 1, 0, 1), ncol = 2, byrow = TRUE)
    result <- tspsa(pts, temp = 50, rate = 1e-3)
    expect_true(is.list(result))
    expect_true("order" %in% names(result))
    expect_true("distance" %in% names(result))
    expect_equal(length(result$order), 4)
    expect_true(result$distance > 0)
})

test_that("tspsa rejects non-matrix", {
    expect_error(tspsa(c(1, 2, 3)))
})

## gaussint.R
test_that("gauss.laguerre integrates exp(-x)", {
    f <- function(x) rep(1, length(x))
    result <- gauss.laguerre(f, m = 5)
    expect_equal(result, 1, tolerance = 0.01)
})

test_that("gauss.hermite returns numeric", {
    f <- function(x) rep(1, length(x))
    result <- gauss.hermite(f, m = 5)
    expect_true(is.numeric(result))
    expect_length(result, 1)
})

test_that("gaussint rejects non-function", {
    expect_error(gaussint("bad", 1:5, 1:5), class = "cmna_invalid_argument")
})

## gradesc.R
test_that("graddsc minimizes simple function", {
    fp <- function(x) 2 * x
    result <- graddsc(fp, 0.5, h = 0.01)
    expect_equal(result, 0, tolerance = 0.1)
})

test_that("gradasc maximizes simple function", {
    fp <- function(x) -2 * (x - 3)
    result <- gradasc(fp, 2.5, h = 0.01)
    expect_equal(result, 3, tolerance = 0.1)
})

test_that("gd rejects non-function", {
    expect_error(gd("bad", 0), class = "cmna_invalid_argument")
})

## goldsect.R
test_that("goldsectmin finds minimum", {
    f <- function(x) (x - 2)^2
    result <- goldsectmin(f, 0, 5)
    expect_equal(result, 2, tolerance = 1e-3)
})

test_that("goldsectmax finds maximum", {
    f <- function(x) -(x - 2)^2
    result <- goldsectmax(f, 0, 5)
    expect_equal(result, 2, tolerance = 1e-3)
})

## refmatrix.R
test_that("rrefmatrix produces identity for invertible matrix", {
    A <- matrix(c(1, 2, 3, 4, 5, 6, 7, 8, 10), nrow = 3, byrow = TRUE)
    result <- rrefmatrix(A)
    expect_equal(result, diag(3), tolerance = 1e-10)
})

test_that("solvematrix solves 3x3 system", {
    A <- matrix(c(1, 0, 0, 0, 1, 0, 0, 0, 1), nrow = 3)
    b <- c(1, 2, 3)
    x <- solvematrix(A, b)
    expect_equal(x, b, tolerance = 1e-10)
})

## lumatrix.R
test_that("lumatrix reconstructs 3x3 matrix", {
    A <- matrix(c(2, 1, 1, 4, 3, 3, 8, 7, 9), nrow = 3, byrow = TRUE)
    lu <- lumatrix(A)
    expect_true(is.list(lu))
    expect_true("L" %in% names(lu))
    expect_true("U" %in% names(lu))
    expect_equal(lu$L %*% lu$U, A, tolerance = 1e-10)
})

## nthroot.R validation
test_that("nthroot handles edge cases", {
    expect_equal(nthroot(0, 3), 0, tolerance = 1e-3)
    expect_equal(nthroot(1, 5), 1, tolerance = 1e-3)
    expect_equal(nthroot(27, 3), 3, tolerance = 1e-2)
})

## resizeImage.R
test_that("resizeImageBL upscales correctly", {
    m <- array(rep(1, 12), dim = c(2, 2, 3))
    result <- resizeImageBL(m, 4, 4)
    expect_equal(dim(result), c(4, 4, 3))
})

## cubicspline.R
test_that("cubicspline rejects mismatched lengths", {
    expect_error(cubicspline(c(1, 2, 3), c(1, 2)),
                 class = "cmna_invalid_argument")
})
