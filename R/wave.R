#' @title Wave Equation using
#'
#' @name wave
#' @rdname wave
#'
#' @description
#' solve heat equation via forward-time central-space method
#'
#' @param u the initial values of u
#' @param alpha the thermal diffusivity coefficient
#' @param xdelta the change in \code{x} at each step in \code{u}
#' @param tdelta the time step
#' @param n the number of steps to take
#'
#' @details
#' The \code{heat} solves the heat equation using the forward-time
#' central-space method in one-dimension.
#'
#' @return a matrix of u values at each time step
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
