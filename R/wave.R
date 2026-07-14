## Copyright (c) 2016-2026, James P. Howard, II <jh@jameshoward.us>
## SPDX-License-Identifier: BSD-2-Clause

#' @title Wave Equation via Finite Differences
#'
#' @name wave
#' @rdname wave
#'
#' @description
#' Solve the one-dimensional wave equation using a finite difference
#' method.
#'
#' @param u a numeric vector of initial displacement values
#' @param alpha a positive numeric scalar giving the wave speed
#' @param xdelta a positive numeric scalar giving the spatial step size
#' @param tdelta a positive numeric scalar giving the time step size
#' @param n a positive integer giving the number of time steps
#'
#' @details
#' `wave` solves the one-dimensional wave equation using a central
#' difference scheme in both space and time. The initial velocity is
#' assumed to be zero. Fixed boundary conditions are applied at the
#' endpoints.
#'
#' @return A matrix with `n + 1` rows, where each row is the
#'   displacement vector `u` at a given time step.
#'
#' @examples
#' speed <- 2
#' x0 <- 0
#' xdelta <- .05
#' x <- seq(x0, 1, xdelta)
#' m <- length(x)
#' u <- sin(x * pi * 2)
#' u[11:21] <- 0
#' tdelta <- .02
#' n <- 40
#' z <- wave(u, speed, xdelta, tdelta, n)

#' @export
wave <- function(u, alpha, xdelta, tdelta, n) {
    .cmna_validate_numeric_vector(u, "u")
    .cmna_validate_positive_scalar(alpha, "alpha")
    .cmna_validate_positive_scalar(xdelta, "xdelta")
    .cmna_validate_positive_scalar(tdelta, "tdelta")
    .cmna_validate_pos_integer(n, "n")

    m <- length(u)
    uarray <- matrix(u, nrow = 1)
    newu <- u

    h <- ((alpha * tdelta) / (xdelta))^2

    ## Initial the zeroth timestep
    oldu <- rep(0, m)
    oldu[2:(m - 1)] <- u[2:(m - 1)] + h *
        (u[1:(m - 2)] - 2 * u[2:(m - 1)] + u[3:m]) / 2

    ## Now iterate
    for(i in 1:n) {
        ustep1 <- (2 * u - oldu)
        ustep2 <- u[1:(m - 2)] - 2 * u[2:(m - 1)] + u[3:m]
        newu <- ustep1 + h * c(0, ustep2, 0)
        oldu <- u
        u <- newu
        uarray <- rbind(uarray, u)
    }

    return(uarray)
}
