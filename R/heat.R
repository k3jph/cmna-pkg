#' @title Heat Equation via Forward-Time Central-Space
#'
#' @name heat
#' @rdname heat
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
