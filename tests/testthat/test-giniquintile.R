test_that("giniquintile computes a valid Gini coefficient", {
    L <- c(4.3, 9.8, 15.4, 22.7)
    result <- giniquintile(L)
    expect_true(is.numeric(result))
    expect_true(result >= 0 && result <= 1)
})

test_that("giniquintile returns higher value for more unequal distribution", {
    L_equal <- c(20, 40, 60, 80)
    L_unequal <- c(4.3, 9.8, 15.4, 22.7)
    expect_gt(giniquintile(L_unequal), giniquintile(L_equal))
})
