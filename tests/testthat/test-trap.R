context("trap")

f <- function(x) { x^2 }
expect_equal(trap(f, 0, 1, n = 10), 1 / 3, 1e-2)
expect_equal(trap(f, 0, 1, n = 100), 1 / 3, 1e-3)
expect_equal(trap(f, 0, 1, n = 1000), 1 / 3, 1e-4)

f <- function(x) { 1 / x }
expect_false(isTRUE(all.equal(trap(f, 1, 10, n = 1000), log(10))))
expect_equal(trap(f, 1, 10, n = 100), log(10), 1e-3)
expect_equal(trap(f, 1, 10, n = 1000), log(10), 1e-4)

f <- function(x) { sin(x)^2 + cos(x)^2 }
expect_equal(trap(f, -pi, pi, n = 10), 2 * pi, 1e-2)
expect_equal(trap(f, -pi, pi, n = 100), 2 * pi, 1e-3)
expect_equal(trap(f, -pi, pi, n = 1000), 2 * pi, 1e-4)
