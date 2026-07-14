test_that("wilkinson has roots at integers 1 through w", {
    for (k in 1:20) {
        expect_equal(wilkinson(k), 0)
    }
})

test_that("wilkinson at 0 equals 20!", {
    expect_equal(wilkinson(0), prod(0 - 1:20))
})

test_that("wilkinson with custom w has correct roots", {
    for (k in 1:5) {
        expect_equal(wilkinson(k, w = 5), 0)
    }
    expect_false(wilkinson(6, w = 5) == 0)
})

test_that("wilkinson with w = 1 is x - 1", {
    expect_equal(wilkinson(0, w = 1), -1)
    expect_equal(wilkinson(1, w = 1), 0)
    expect_equal(wilkinson(2, w = 1), 1)
})

test_that("wilkinson accepts vector input", {
    result <- wilkinson(1:5, w = 5)
    expect_equal(result, rep(0, 5))
})

test_that("wilkinson rejects invalid w", {
    expect_error(wilkinson(1, w = 0), class = "cmna_invalid_argument")
    expect_error(wilkinson(1, w = -1), class = "cmna_invalid_argument")
    expect_error(wilkinson(1, w = 2.5), class = "cmna_invalid_argument")
})
