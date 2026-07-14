## Copyright (c) 2016-2026, James P. Howard, II <jh@jameshoward.us>
## SPDX-License-Identifier: BSD-2-Clause

#' @title Nearest Neighbor Interpolation
#'
#' @description
#' Find the nearest neighbor for a set of data points.
#'
#' @param p a numeric matrix of variable values, where each row is a data point
#' @param y a numeric vector of values, each entry corresponding to one row
#'   in `p`
#' @param q a numeric matrix of query points, where each row is a point to
#'   interpolate and the number of columns must match `p`
#'
#' @details
#' `nn` finds the n-dimensional nearest neighbor among the rows of `p`
#' for the query point `q`, using Euclidean distance, and returns the
#' corresponding value from `y`.
#'
#' @return The interpolated value from `y` for the nearest neighbor of `q`.
#'
#' @family interp
#'
#' @examples
#' p <- matrix(floor(runif(100, 0, 9)), 20)
#' y <- floor(runif(20, 0, 9))
#' q <- matrix(floor(runif(5, 0, 9)), 1)
#' nn(p, y, q)
#'
#' @export
nn <- function(p, y, q) {
    .cmna_validate_matrix(p, "p")
    .cmna_validate_matrix(q, "q")
    .cmna_validate_numeric_vector(y, "y")
    if (ncol(p) != ncol(q))
        .cmna_abort(
            "`p` and `q` must have the same number of columns",
            "cmna_invalid_argument",
            p_ncol = ncol(p),
            q_ncol = ncol(q)
        )

    ## Repeat the rows of q to simplfy the  calculation
    qprime <- t(matrix(rep(q, nrow(p)), ncol(p)))
    d <- sqrt(rowSums((p - qprime)^2))
    return(y[which.min(d)])
}
