test_that("himmelblau is zero at known minima", {
    expect_equal(himmelblau(c(3, 2)), 0)
})

test_that("himmelblau is positive away from minima", {
    expect_gt(himmelblau(c(0, 0)), 0)
    expect_gt(himmelblau(c(1, 1)), 0)
})

test_that("himmelblau at origin has known value", {
    expect_equal(himmelblau(c(0, 0)), 11^2 + 7^2)
})
