test_that("fibonacci uses zero-based indexing", {
    expect_identical(fibonacci(0), 0)
    expect_identical(fibonacci(1), 1)
    expect_identical(fibonacci(2), 1)
    expect_identical(fibonacci(10), 55)
})

test_that("fibonacci computes the largest exact R result", {
    expect_identical(fibonacci(78), 8944394323791464)
})

test_that("fibonacci rejects invalid indices", {
    expect_error(fibonacci(-1), class = "cmna_invalid_argument")
    expect_error(fibonacci(1.5), class = "cmna_invalid_argument")
    expect_error(fibonacci("10"), class = "cmna_invalid_argument")
    expect_error(fibonacci(Inf), class = "cmna_invalid_argument")
})

test_that("fibonacci rejects inexact-range indices", {
    expect_error(fibonacci(79), class = "cmna_domain_error")
})
