#' @title Initial value problems for systems of ordinary differential equations
#'
#' @name ivpsys
#' @rdname ivpsys
#' 
#' @description
#' solve initial value problems for systems ordinary differential equations
#'
#' @param f function to integrate
#' @param x0 the initial value of x
#' @param y0 the vector initial values of y
#' @param h selected step size
#' @param n the number of steps
#'
#' @details
#' The \code{euler} method implements the Euler method for solving
#' differential equations.  The code{midptivp} method solves initial
#' value problems using the second-order Runge-Kutta method.  The
#' \code{rungekutta4} method is the fourth-order Runge-Kutta method.
#' 
#' @return a data frame of \code{x} and \code{y} values
#'
#' @examples
#' f <- function(x, y) { y / (2 * x + 1) }
#' ivp.euler <- euler(f, 0, 1, 1/100, 100)

#' @rdname ivpsys
#' @export
eulersys <- function(f, x0, y0, h, n) {
    x <- x0
    y <- y0
    
    ## If y0 values are named, the data frame names them!  
    ## The value names produced by f(x, y) should match.
    values <- data.frame(x = x, t(y0))
    for(i in 1:n) {
        y0 <- y0 + h * f(x0, y0)
        x0 <- x0 + h
        values <- rbind(values, data.frame(x = x0, t(y0)))
    }
    
    return(values)   
}
