#' @name findiff
#' @rdname findiff
#'
#' @title Finite Differences
#'
#' @description
#' Finite differences formulas
#'
#' @param f function to differentiate
#' @param x the \code{x}-value to differentiate at
#' @param h the step-size for evaluation
#' @param tol the error tolerance for \code{symdiff}
#' @param m the maximum number of convergence steps in \code{symdiff} 
#' @param n the maximum number of convergence steps in \code{rdiff}
#' 
#' @details
#' 
#' The \code{findiff} formula uses the finite differences formula to
#' find the derivative of \code{f} at \code{x}.  The value of \code{h}
#' is the step size of the evaluation. The function \code{findiff2}
#' provides the second derivative.
#'
#' @return the value of the derivative
#'
#' @family differentiation
#'
#' @examples
#' findiff(sin, pi, 1e-3)
#' symdiff(sin, pi, 1e-3)
#' 
#' @export
findiff <- function(f, x, h) {
    return((f(x + h) - f(x)) / h)
}

#' @rdname findiff
#' @export
symdiff <- function(f, x, h = tol * 10, 
                    tol = 1e-3, m = 100) {
    i <- 0
    
    lastdx <- (f(x + h) - f(x - h)) / (2 * h)
    while(i < m) {
        h <- h / 2
        dx <- (f(x + h) - f(x - h)) / (2 * h)
        if((abs(dx - lastdx) < tol))
            return(dx)
        lastdx <- dx
    }
}

#' @rdname findiff
#' @export
findiff2 <- function(f, x, h) {
    return((f(x + h) - 2 * f(x) + f(x - h)) / h^2)
}

#' @rdname findiff
#' @export
rdiff <- function(f, x, n = 10, h = 1e-4) {
    if(n == 1)
        return(symiff(f, x, h = h))
    
    dx <- (4 * rdiff(f, x, n = n - 1, h = h / 2) -
               symdiff(f, x, h = h)) / 3
    return(dx)
}
