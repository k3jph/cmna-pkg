#' @title Initial value problems
#'
#' @name ivp
#' @rdname ivp
#' 
#' @description
#' solve initial value problems for ordinary differential equations
#'
#' @param f function to integrate
#' @param x0 the initial value of x
#' @param y0 the initial value of y
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
#' ivp.midpt <- midptivp(f, 0, 1, 1/100, 100)
#' ivp.rk4 <- rungekutta4(f, 0, 1, 1/100, 100)

#' @export
euler <- function(f, x0, y0, h, n) {
    x <- x0
    y <- y0
    
    for(i in 1:n) {
        y0 <- y0 + h * f(x0, y0)
        x0 <- x0 + h
        x <- c(x, x0)
        y <- c(y, y0)
    }
    
    return(data.frame(x = x, y = y))
}

#' @rdname ivp
#' @export
midptivp <- function(f, x0, y0, h, n) {
    x <- x0
    y <- y0
    
    for(i in 1:n) {
        s1 <- h * f(x0, y0)
        s2 <- h * f(x0 + h / 2, y0 + s1 / 2)
        y0 <- y0 + s2
        
        x0 <- x0 + h
        x <- c(x, x0)
        y <- c(y, y0)
    }
    
    return(data.frame(x = x, y = y))
}

#' @rdname ivp
#' @export
rungekutta4 <- function(f, x0, y0, h, n) {
    x <- x0
    y <- y0
    
    for(i in 1:n) {
        s1 <- h * f(x0, y0)
        s2 <- h * f(x0 + h / 2, y0 + s1 / 2)
        s3 <- h * f(x0 + h / 2, y0 + s2 / 2)
        s4 <- h * f(x0 + h, y0 + s3)
        y0 <- y0 + s1 / 6 + s2 / 3 + s3 / 3 + s4 / 6
        
        x0 <- x0 + h
        x <- c(x, x0)
        y <- c(y, y0)
    }
    
    return(data.frame(x = x, y = y))
}

#' @rdname ivp
#' @export
adamsbashforth <- function(f, x0, y0, h, n) {
    
    ## Quick Euler the value of x1, y1
    y1 <- y0 + h * f(x0, y0)
    x1 <- x0 + h
    
    x <- c(x0, x1)
    y <- c(y0, y1)
    n <- n - 1
    
    for(i in 1:n) {
        yn <- y1 + 1.5 * h * f(x1, y1) - .5 * h * f(x0, y0)
        xn <- x1 + h

        y0 <- y1
        x0 <- x1
        y1 <- yn
        x1 <- xn
        
        y <- c(y, y1)
        x <- c(x, x1)
    }
        
    return(data.frame(x = x, y = y))
}
