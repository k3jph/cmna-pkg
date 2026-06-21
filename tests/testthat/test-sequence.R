test_that("cmna_sequence constructs ascending sequences", {
    expect_equal(cmna_sequence(1, 5, 1), 1:5)
    expect_equal(cmna_sequence(0, 10, 2), c(0, 2, 4, 6, 8, 10))
    expect_equal(cmna_sequence(-5, 0, 1), -5:0)
})

test_that("cmna_sequence constructs descending sequences", {
    expect_equal(cmna_sequence(5, 1, -1), 5:1)
    expect_equal(cmna_sequence(10, 0, -2), c(10, 8, 6, 4, 2, 0))
    expect_equal(cmna_sequence(0, -5, -1), 0:-5)
})

test_that("cmna_sequence handles floating increments", {
    expect_equal(cmna_sequence(0, 1, 0.1), seq(0, 1, by = 0.1), tolerance = 1e-15)
})

test_that("cmna_sequence stops before crossing uneven endpoints", {
    expect_equal(cmna_sequence(0, 5, 3), c(0, 3))
    expect_equal(cmna_sequence(5, 0, -3), c(5, 2))
})

test_that("cmna_sequence returns equal endpoints once", {
    expect_identical(cmna_sequence(2, 2, 1), 2)
    expect_identical(cmna_sequence(2, 2, -1), 2)
})

test_that("cmna_sequence rejects invalid increments", {
    expect_error(cmna_sequence(1, 5, 0), class = "cmna_invalid_argument")
    expect_error(cmna_sequence(1, 5, -1), class = "cmna_invalid_argument")
    expect_error(cmna_sequence(5, 1, 1), class = "cmna_invalid_argument")
})

test_that("cmna_sequence rejects non-finite inputs", {
    expect_error(cmna_sequence(Inf, 5, 1), class = "cmna_invalid_argument")
    expect_error(cmna_sequence(1, NaN, 1), class = "cmna_invalid_argument")
    expect_error(cmna_sequence(1, 5, NA_real_), class = "cmna_invalid_argument")
})
