## Copyright (c) 2016-2026, James P. Howard, II <jh@jameshoward.us>
## SPDX-License-Identifier: BSD-2-Clause

#' @title Norm of a vector
#'
#' @description
#' Compute the Euclidean (L2) norm of a numeric vector.
#'
#' @param b a numeric vector
#'
#' @details
#' `vecnorm` computes the Euclidean norm of `b`, defined as
#' \eqn{\sqrt{\sum b_i^2}}.
#'
#' @return A numeric scalar giving the norm.
#'
#' @family linear
#'
#' @examples
#' x <- c(1, 2, 3)
#' vecnorm(x)
#'
#' @export
vecnorm <- function(b) {
    .cmna_validate_numeric_vector(b, "b")

    return(sqrt(sum(b^2)))
}
