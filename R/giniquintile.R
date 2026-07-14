## Copyright (c) 2016-2026, James P. Howard, II <jh@jameshoward.us>
## SPDX-License-Identifier: BSD-2-Clause

#' @title Gini Coefficient from Quintile Data
#'
#' @description
#' Calculate the Gini coefficient from quintile data.
#'
#' @param L numeric vector of percentages at the 20th, 40th, 60th, and
#'   80th percentiles
#'
#' @details
#' Computes the Gini coefficient using Gerber's quintile rule, which
#' approximates the area between the Lorenz curve and the line of
#' equality from four cumulative income-share percentages.
#'
#' @return The estimated Gini coefficient as a numeric scalar.
#'
#' @family integration
#' @family newton-cotes
#'
#' @examples
#' L <- c(4.3, 9.8, 15.4, 22.7)
#' giniquintile(L)
#'
#' @references
#' Leon Gerber, "A Quintile Rule for the Gini Coefficient",
#' *Mathematics Magazine*, 80:2, April 2007.
#'
#' @export
giniquintile <- function(L) {
    .cmna_validate_numeric_vector(L, "L")

    x <- c(.2, .4, .6, .8)
    L <- x - cumsum(L / 100)

    return(25 / 144 * (3*L[1] + 2*L[2] + 2*L[3] + 3*L[4]))
}
