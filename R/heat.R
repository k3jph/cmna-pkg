## Copyright (c) 2016-2026, James P. Howard, II <jh@jameshoward.us>
## SPDX-License-Identifier: BSD-2-Clause

#' @title Heat Equation via Forward-Time Central-Space
#'
#' @name heat
#' @rdname heat
#'
#' @description
#' Solve the one-dimensional heat equation using the forward-time
#' central-space (FTCS) finite difference method.
#'
#' @param u a numeric vector of initial values
#' @param alpha a positive numeric scalar giving the thermal diffusivity
#'   coefficient
#' @param xdelta a positive numeric scalar giving the spatial step size
#' @param tdelta a positive numeric scalar giving the time step size
#' @param n a positive integer giving the number of time steps
#'
#' @details
#' `heat` solves the heat equation using the forward-time central-space
#' method in one dimension. Periodic boundary conditions are applied by
#' copying the last element to the first at each time step.
#'
#' @return A matrix with `n + 1` rows, where each row is the solution
#'   vector `u` at a given time step.
#'
#' @examples
#' alpha <- 1
#' x0 <- 0
#' xdelta <- .05
#' x <- seq(x0, 1, xdelta)
#' u <- sin(x^4 * pi)
#' tdelta <- .001
#' n <- 25
#' z <- heat(u, alpha, xdelta, tdelta, n)
#'
#' @export
heat <- function(u, alpha, xdelta, tdelta, n) {
    .cmna_validate_numeric_vector(u, "u")
    .cmna_validate_positive_scalar(alpha, "alpha")
    .cmna_validate_positive_scalar(xdelta, "xdelta")
    .cmna_validate_positive_scalar(tdelta, "tdelta")
    .cmna_validate_pos_integer(n, "n")

    m <- length(u)
    uarray <- matrix(u, nrow = 1)
    newu <- u

    h <- alpha * tdelta / xdelta^2
    for(i in 1:n) {
        for(j in 2:(m - 1)) {
            ustep <- (u[j - 1] + u[j + 1] - 2 * u[j])
            newu[j] <- u[j] + h * ustep
        }
        u <- newu
        u[1] <- u[m]
        uarray <- rbind(uarray, u)
    }

    return(uarray)
}
