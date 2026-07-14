test_that("naivediv computes correct quotient and remainder", {
    result <- naivediv(17, 5)
    expect_equal(result$quotient, 3)
    expect_equal(result$remainder, 2)
})

test_that("longdiv computes correct quotient and remainder", {
    result <- longdiv(17, 5)
    expect_equal(result$quotient, 3)
    expect_equal(result$remainder, 2)
})

test_that("naivediv and longdiv agree on various inputs", {
    cases <- list(c(0, 1), c(1, 1), c(7, 3), c(100, 10),
                  c(255, 16), c(1000, 7))
    for (case in cases) {
        naive <- naivediv(case[1], case[2])
        long <- longdiv(case[1], case[2])
        expect_equal(naive$quotient, long$quotient)
        expect_equal(naive$remainder, long$remainder)
        expect_equal(case[1], naive$quotient * case[2] + naive$remainder)
    }
})

test_that("division of zero returns zero quotient and remainder", {
    expect_equal(naivediv(0, 5)$quotient, 0)
    expect_equal(naivediv(0, 5)$remainder, 0)
    expect_equal(longdiv(0, 5)$quotient, 0)
    expect_equal(longdiv(0, 5)$remainder, 0)
})

test_that("exact division produces zero remainder", {
    expect_equal(naivediv(15, 5)$remainder, 0)
    expect_equal(naivediv(15, 5)$quotient, 3)
    expect_equal(longdiv(15, 5)$remainder, 0)
})

test_that("division by 1 returns the dividend", {
    expect_equal(naivediv(42, 1)$quotient, 42)
    expect_equal(naivediv(42, 1)$remainder, 0)
})

test_that("division rejects zero divisor", {
    expect_error(naivediv(10, 0), class = "cmna_invalid_argument")
    expect_error(longdiv(10, 0), class = "cmna_invalid_argument")
})

test_that("division rejects negative inputs", {
    expect_error(naivediv(-5, 3), class = "cmna_invalid_argument")
    expect_error(naivediv(5, -3), class = "cmna_invalid_argument")
    expect_error(longdiv(-5, 3), class = "cmna_invalid_argument")
})

test_that("division rejects non-integer inputs", {
    expect_error(naivediv(5.5, 2), class = "cmna_invalid_argument")
    expect_error(longdiv(5, 2.5), class = "cmna_invalid_argument")
})

test_that("division rejects non-numeric inputs", {
    expect_error(naivediv("a", 2), class = "cmna_invalid_argument")
    expect_error(longdiv(5, "b"), class = "cmna_invalid_argument")
})
