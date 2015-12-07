#' @title Secant Method
#'
#' @description
#' The secant method for root finding
#'
#' @param f function to integrate
#' @param x an initial estimate of the root
#' @param tol the error tolerance
#' @param m the maximum number of iterations
#' 
#' @details
#'
#' The secant method for root finding extends Newton's method to
#' estimate the derivative.  It will return when the interval between
#' them is less than \code{tol}, the error tolerance.  However, this
#' implementation also stop if after \code{m} iterations.
#' 
#' @return the real root found
#'
#' @family optimz
#'
#' @examples
#' f <- function(x) { x^3 - 2 * x^2 - 159 * x - 540 }
#' secant(f, 1)
#'
#' @export
secant <- function(f, x, tol = 1e-3, m = 100) {
    i <- 0
    
    oldx <- x
    oldfx <- f(x)
    x <- oldx + 10 * tol
    
    while(abs(x - oldx) > tol) {
        i <- i + 1
        if (i > m)
            stop("No solution found")
        
        fx <- f(x)
        newx <- x - fx * ((x - oldx) / (fx - oldfx))
        oldx <- x
        oldfx <- fx
        x <- newx
    }
    
    return(x)
}
