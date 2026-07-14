## Copyright (c) 2016-2026, James P. Howard, II <jh@jameshoward.us>
## SPDX-License-Identifier: BSD-2-Clause

#' @title Himmelblau's function
#'
#' @description
#' Evaluate Himmelblau's test function for optimization.
#'
#' @param x a numeric vector of length 2
#'
#' @details
#' Himmelblau's function is defined as
#' \deqn{f(x_1, x_2) = (x_1^2 + x_2 - 11)^2 + (x_1 + x_2^2 - 7)^2}
#'
#' It has four identical local minima, each with value zero, at
#' approximately `(3, 2)`, `(-2.805, 3.131)`, `(-3.779, -3.283)`,
#' and `(3.584, -1.848)`.
#'
#' @return The value of the function at `x`.
#'
#' @family optimization
#'
#' @examples
#' himmelblau(c(3, 2))
#' himmelblau(c(0, 0))
#'
#' @export
himmelblau <- function(x) {
    (x[1]^2 + x[2] - 11)^2 + (x[1] + x[2]^2 - 7)^2
}
