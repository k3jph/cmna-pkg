test_that("isPrime correctly identifies small primes", {
    primes <- c(2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47)
    for (p in primes) {
        expect_true(isPrime(p), info = paste("n =", p))
    }
})

test_that("isPrime correctly identifies composites", {
    composites <- c(4, 6, 8, 9, 10, 12, 14, 15, 16, 18, 20, 21, 25, 100)
    for (n in composites) {
        expect_false(isPrime(n), info = paste("n =", n))
    }
})

test_that("isPrime returns FALSE for 1", {
    expect_false(isPrime(1))
})

test_that("isPrime identifies 2 as prime", {
    expect_true(isPrime(2))
})

test_that("isPrime handles larger primes", {
    expect_true(isPrime(89))
    expect_true(isPrime(97))
    expect_true(isPrime(101))
})

test_that("isPrime rejects invalid inputs", {
    expect_error(isPrime(0), class = "cmna_invalid_argument")
    expect_error(isPrime(-5), class = "cmna_invalid_argument")
    expect_error(isPrime(3.5), class = "cmna_invalid_argument")
    expect_error(isPrime("a"), class = "cmna_invalid_argument")
})
