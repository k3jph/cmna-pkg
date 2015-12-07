#' @title The Bisection Method
#'
#' @description
#' Use the bisection method to find real roots
#'
#' @param f function to integrate
#' @param a the a bound of the search region
#' @param b the b bound of the search region
#' @param tol the error tolerance
#' @param m the maximum number of iterations
#' 
#' @details
#' 
#' The bisection method functions by repeatedly halving the interval
#' between \code{a} and \code{b} and will return when the
#' interval between them is less than \code{tol}, the error tolerance.
#' However, this implementation also stop if after \code{maxiter}
#' iterations.
#'
#' @return the real root found
#'
#' @family optimz
#'
#' @examples
#' f <- function(x) { x^3 - 2 * x^2 - 159 * x - 540}
#' bisection(f, 0, 10)
#'
#' @export
bisection <- function(f, a, b, tol = 1e-3, m = 100) {
    iter <- 0
    f.a <- f(a)
    f.b <- f(b)
    
    while (abs(b - a) > tol) {
        iter <- iter + 1
        if (iter > m)
            break

        xmid <- (a + b) / 2
        ymid <-  f(xmid)
        if (f.a * ymid > 0) {
            a <- xmid
            f.a <- ymid
        } else {
            b <- xmid
            f.b <- ymid
        }
    }

    ## Interpolate a midpoint for return value
    root <- (a + b) / 2
    return(root)
}
