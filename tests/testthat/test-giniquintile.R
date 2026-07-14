test_that("giniquintile gives zero for perfect equality", {
    result <- giniquintile(c(20, 20, 20, 20))
    expect_equal(result, 0, tolerance = 1e-10)
})

test_that("giniquintile computes known Gini for US 2005 data", {
    L <- c(4.3, 9.8, 15.4, 22.7)
    result <- giniquintile(L)
    expect_true(result > 0 && result < 1)
    expect_equal(result, 0.4224, tolerance = 0.001)
})

test_that("giniquintile returns higher value for more unequal distribution", {
    L_equal <- c(20, 20, 20, 20)
    L_unequal <- c(4.3, 9.8, 15.4, 22.7)
    expect_gt(giniquintile(L_unequal), giniquintile(L_equal))
})
