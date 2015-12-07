#' @title Newton's method
#'
#' @description
#' Use Newton's method to find real roots
#'
#' @param f function to integrate
#' @param fp function representing the derivative of \code{f}
#' @param x an initial estimate of the root
#' @param tol the error tolerance
#' @param m the maximum number of iterations
#' 
#' @details
#'
#' Newton's method finds real roots of a function, but requires knowing
#' the function derivative.  It will return when the interval between
#' them is less than \code{tol}, the error tolerance.  However, this
#' implementation also stops after \code{m} iterations.
#'
#' @return the real root found
#'
#' @family optimz
#'
#' @examples
#' f <- function(x) { x^3 - 2 * x^2 - 159 * x - 540 }
#' fp <- function(x) {3 * x^2 - 4 * x - 159 }
#' newton(f, fp, 1)
#'
#' @export
newton <- function(f, fp, x, tol = 1e-3, m = 100) {
    iter <- 0

    oldx <- x
    x <- oldx + 10 * tol

    while(abs(x - oldx) > tol) {
        iter <- iter + 1
        if(iter > m)
            stop("No solution found")
        oldx <- x
        x <- x - f(x) / fp(x)
    }

    return(x)
}
