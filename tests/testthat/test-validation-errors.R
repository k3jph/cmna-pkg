## Tests for input validation error paths across function families

test_that("root finders reject non-function f", {
    expect_error(bisection("not_a_function", 0, 1), class = "cmna_invalid_argument")
    expect_error(newton("not_a_function", 1), class = "cmna_invalid_argument")
    expect_error(secant("not_a_function", 1), class = "cmna_invalid_argument")
})

test_that("root finders reject non-numeric scalars", {
    f <- function(x) x
    expect_error(bisection(f, "a", 1), class = "cmna_invalid_argument")
    expect_error(newton(f, "a"), class = "cmna_invalid_argument")
    expect_error(secant(f, "a"), class = "cmna_invalid_argument")
})

test_that("IVP solvers reject non-function f", {
    expect_error(euler("bad", 0, 1, 0.1, 10), class = "cmna_invalid_argument")
    expect_error(rungekutta4("bad", 0, 1, 0.1, 10), class = "cmna_invalid_argument")
})

test_that("polynomial evaluators reject non-numeric", {
    expect_error(horner("abc", c(1, 2)), "must be numeric")
    expect_error(naivepoly("abc", c(1, 2)), "must be numeric")
})

test_that("summation functions reject non-numeric", {
    expect_error(naivesum("abc"), class = "cmna_invalid_argument")
    expect_error(kahansum("abc"), class = "cmna_invalid_argument")
    expect_error(pwisesum("abc"), class = "cmna_invalid_argument")
})

test_that("matrix functions reject non-matrix input", {
    expect_error(detmatrix(c(1, 2, 3)), class = "cmna_invalid_argument")
    expect_error(invmatrix(c(1, 2, 3)), class = "cmna_invalid_argument")
    expect_error(refmatrix(c(1, 2, 3)), class = "cmna_invalid_argument")
})

test_that("row operations reject out-of-bounds rows", {
    m <- matrix(1:4, nrow = 2)
    expect_error(swaprows(m, 1, 5))
    expect_error(scalerow(m, 5, 2))
    expect_error(replacerow(m, 5, 1, 2))
})

test_that("bezier rejects wrong number of control points", {
    expect_error(qbezier(c(1, 2), c(1, 2), seq(0, 1, 0.1)),
                 class = "cmna_invalid_argument")
    expect_error(cbezier(c(1, 2, 3), c(1, 2, 3), seq(0, 1, 0.1)),
                 class = "cmna_invalid_argument")
})

test_that("integration functions reject non-function", {
    expect_error(trap("bad", 0, 1, 10), class = "cmna_invalid_argument")
    expect_error(simp("bad", 0, 1, 10), class = "cmna_invalid_argument")
    expect_error(romberg("bad", 0, 1), class = "cmna_invalid_argument")
})

test_that("optimization functions reject non-function", {
    expect_error(goldsectmin("bad", 0, 1), class = "cmna_invalid_argument")
    expect_error(goldsectmax("bad", 0, 1), class = "cmna_invalid_argument")
    expect_error(sa("bad", 0), class = "cmna_invalid_argument")
})

test_that("nthroot rejects non-positive n", {
    expect_error(nthroot(8, 0), class = "cmna_invalid_argument")
    expect_error(nthroot(8, -1), class = "cmna_invalid_argument")
})

test_that("fibonacci rejects negative n", {
    expect_error(fibonacci(-1), class = "cmna_invalid_argument")
})

test_that("vecnorm rejects non-numeric input", {
    expect_error(vecnorm("abc"), class = "cmna_invalid_argument")
})

test_that("isPrime rejects non-positive input", {
    expect_error(isPrime(0), class = "cmna_invalid_argument")
    expect_error(isPrime(-5), class = "cmna_invalid_argument")
})
