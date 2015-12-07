#' @title The n-th root formula
#'
#' @description
#' Find the n-th root of real numbers
#'
#' @param a a positive real number
#' @param n n
#' @param tol the permitted error tolerance
#'
#' @details
#' The \code{nthroot} function finds the \code{n}th root of \code{a} via
#' an iterative process.
#'
#' @return the root
#'
#' @family algebra
#' 
#' @examples
#' nthroot(100, 2)
#' nthroot(65536, 4)
#' nthroot(1000, 3)
#' 
#' @export
nthroot <- function(a, n, tol = 1 / 1000) {
    x <- 1
    deltax <- tol * 10
    
    while(abs(deltax) > tol) {
        deltax <- (1 / n) * (a / x ^ (n - 1) - x)
        x <- x + deltax
    }
    
    return(x)
}
