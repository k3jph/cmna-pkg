test_that("nthroot computes canonical positive roots", {
    expect_equal(nthroot(100, 2, tol = 1e-12), 10, tolerance = 1e-10)
    expect_equal(nthroot(1000, 3, tol = 1e-12), 10, tolerance = 1e-10)
    expect_equal(nthroot(65536, 4, tol = 1e-12), 16, tolerance = 1e-10)
})

test_that("nthroot handles zero and first roots exactly", {
    expect_identical(nthroot(0, 7), 0)
    expect_identical(nthroot(-12, 1), -12)
})

test_that("nthroot permits negative radicands for odd degrees", {
    expect_equal(nthroot(-125, 3, tol = 1e-12), -5, tolerance = 1e-10)
})

test_that("nthroot rejects negative radicands for even degrees", {
    expect_error(nthroot(-16, 2), class = "cmna_domain_error")
})

test_that("nthroot validates degree and controls", {
    expect_error(nthroot(16, 0), class = "cmna_invalid_argument")
    expect_error(nthroot(16, 2.5), class = "cmna_invalid_argument")
    expect_error(nthroot(16, "2"), class = "cmna_invalid_argument")
    expect_error(nthroot(16, 2, tol = 0), class = "cmna_invalid_argument")
    expect_error(nthroot(16, 2, m = 0), class = "cmna_invalid_argument")
})

test_that("nthroot validates the radicand", {
    expect_error(nthroot(Inf, 2), class = "cmna_invalid_argument")
    expect_error(nthroot(NaN, 2), class = "cmna_invalid_argument")
})

test_that("nthroot exposes exhausted iteration limits", {
    expect_error(
        nthroot(3, 7, tol = 1e-15, m = 1),
        class = "cmna_iteration_limit"
    )
    expect_error(
        nthroot(3, 7, tol = 1e-15, m = 1),
        class = "cmna_convergence_failure"
    )
})
