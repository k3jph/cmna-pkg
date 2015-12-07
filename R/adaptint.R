#' @title Adaptive Integration
#'
#' @description
#' Adaptive integration
#'
#' @param f function to integrate
#' @param a the a-bound of integration
#' @param b the b-bound of integration
#' @param n the maximum recursive depth
#' @param tol the maximum error tolerance
#'
#' @details
#' The \code{adaptint} function uses Romberg's rule to calculate the
#' integral of the function \code{f} over the interval from \code{a}
#' to \code{b}.  The parameter \code{n} sets the number of intervals
#' to use when evaluating.  Additional options are passed to the
#' function \code{f} when evaluating.
#'
#' @return the value of the integral
#'
#' @family integration
#' @family newton-cotes
#' @family adaptive
#'
#' @examples
#' f <- function(x) { sin(x)^2 + log(x) }
#' adaptint(f, 1, 10, n = 4)
#' adaptint(f, 1, 10, n = 5)
#' adaptint(f, 1, 10, n = 10)
#'
#' @export
adaptint <- function(f, a, b, n = 10, tol = 1e-6) {
    if(n == 1)
        area <- midpt(f, a, b, m = 2)
    else {
        q1 <- midpt(f, a, b, m = 1)
        q2 <- midpt(f, a, b, m = 2)
        if(abs(q1 - q2) > 3 * tol) {
            n = n - 1
            tol <- tol / 2
            c <- (a + b) / 2
            lt <- adaptint(f, a, c, n = n, tol = tol) 
            rt <- adaptint(f, c, b, n = n, tol = tol)
            area <- lt + rt
        } else
            area <- q2            
    }
    
    return(area)
}
