## Independent oracle tests for fundamentals

test_that("naivesum/kahansum/pwisesum agree on exact integer sums", {
    x <- as.numeric(1:100)
    exact <- 5050
    expect_equal(naivesum(x), exact)
    expect_equal(kahansum(x), exact)
    expect_equal(pwisesum(x), exact)
})

test_that("summation functions handle single element", {
    expect_equal(naivesum(42), 42)
    expect_equal(kahansum(42), 42)
    expect_equal(pwisesum(42), 42)
})

test_that("division algorithms give correct quotient and remainder", {
    result <- longdiv(17, 5)
    expect_equal(result$quotient, 3)
    expect_equal(result$remainder, 2)
    expect_equal(result$quotient * 5 + result$remainder, 17)

    result2 <- naivediv(17, 5)
    expect_equal(result2$quotient, 3)
    expect_equal(result2$remainder, 2)
})

test_that("quadratic formula gives exact roots for x^2 - 5x + 6", {
    roots <- quadratic(1, -5, 6)
    expect_true(setequal(sort(roots), c(2, 3)))
})

test_that("quadratic formula handles discriminant = 0", {
    roots <- quadratic(1, -2, 1)
    expect_equal(roots[1], 1)
    expect_equal(roots[2], 1)
})

test_that("quadratic2 matches quadratic", {
    r1 <- sort(quadratic(1, -5, 6))
    r2 <- sort(quadratic2(1, -5, 6))
    expect_equal(r1, r2, tolerance = 1e-10)
})

test_that("fibonacci produces correct sequence", {
    expect_equal(fibonacci(0), 0)
    expect_equal(fibonacci(1), 1)
    expect_equal(fibonacci(2), 1)
    expect_equal(fibonacci(10), 55)
    expect_equal(fibonacci(20), 6765)
})

test_that("isPrime correctly identifies primes and composites", {
    primes <- c(2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31)
    composites <- c(1, 4, 6, 8, 9, 10, 12, 14, 15, 16, 25)
    for (p in primes) expect_true(isPrime(p))
    for (c in composites) expect_false(isPrime(c))
})

test_that("nthroot satisfies x^n = a", {
    for (a in c(8, 27, 81, 100000)) {
        for (n in c(2, 3, 4, 5)) {
            x <- nthroot(a, n, tol = 1e-10)
            expect_equal(x^n, a, tolerance = 1e-6)
        }
    }
})

test_that("nthroot of negative odd-root", {
    x <- nthroot(-27, 3, tol = 1e-10)
    expect_equal(x, -3, tolerance = 1e-8)
    expect_equal(x^3, -27, tolerance = 1e-6)
})

test_that("wilkinson polynomial has roots at 1..20", {
    for (k in 1:20) {
        expect_equal(wilkinson(k), 0)
    }
})

test_that("wilkinson polynomial at x=0 equals 20!", {
    expect_equal(wilkinson(0), factorial(20), tolerance = 1e-10)
})

test_that("himmelblau has known minimum near (3, 2)", {
    expect_equal(himmelblau(c(3, 2)), 0)
})
