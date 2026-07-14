test_that("vecnorm computes Euclidean norm correctly", {
    expect_equal(vecnorm(c(3, 4)), 5)
    expect_equal(vecnorm(c(1, 0, 0)), 1)
    expect_equal(vecnorm(c(0, 0, 0)), 0)
})

test_that("vecnorm of unit vectors is 1", {
    expect_equal(vecnorm(c(1, 0)), 1)
    expect_equal(vecnorm(c(0, 1)), 1)
})

test_that("vecnorm of a single element is its absolute value", {
    expect_equal(vecnorm(5), 5)
    expect_equal(vecnorm(-3), 3)
})

test_that("vecnorm of 3-4-5 right triangle", {
    expect_equal(vecnorm(c(3, 4)), 5)
})
