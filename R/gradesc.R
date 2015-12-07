#' @title Gradient descent
#'
#' @name gradient
#' @rdname gradient
#' 
#' @description
#' Use gradient descent to find local minima
#'
#' @param fp function representing the derivative of \code{f}
#' @param x an initial estimate of the minima
#' @param h the step size
#' @param tol the error tolerance
#' @param m the maximum number of iterations
#' 
#' @details
#'
#' Gradient descent can be used to find local minima of functions.  It
#' will return an approximation based on the step size \code{h} and
#' \code{fp}.  The \code{tol} is the error tolerance, \code{x} is the
#' initial guess at the minimum.  This implementation also stops after
#' \code{m} iterations.
#'
#' @return the \code{x} value of the minimum found
#'
#' @family optimz
#'
#' @examples
#' fp <- function(x) { x^3 + 3x^2 - 1 }
#' graddsc(fp, x)
#'
#' @export
graddsc <- function(fp, x, h = 1e-3, tol = 1e-4, m = 1e3) {
    iter <- 0
    
    oldx <- x
    x = x - h * fp(x)
    
    while(abs(x - oldx) > tol) {
        iter <- iter + 1
        if(iter > m)
            stop("No solution found")
        oldx <- x
        x = x - h * fp(x)
    }
    
    return(x)
}

#' @rdname gradient
#' @export
gradasc <- function(fp, x, h = 1e-3, tol = 1e-4, m = 1e3) {
    iter <- 0
    
    oldx <- x
    x = x + h * fp(x)
    
    while(abs(x - oldx) > tol) {
        iter <- iter + 1
        if(iter > m)
            stop("No solution found")
        oldx <- x
        x = x + h * fp(x)
    }
    
    return(x)
}
    
