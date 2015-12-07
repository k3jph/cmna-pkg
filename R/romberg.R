#' @title Romberg Integration
#'
#' @description
#' Romberg's adaptive integration
#'
#' @param f function to integrate
#' @param a the lowerbound of integration
#' @param b the upperbound of integration
#' @param m the maximum number of iterations
#' @param tab if \code{TRUE}, return the table of values
#'
#' @details
#' The \code{romberg} function uses Romberg's rule to calculate the
#' integral of the function \code{f} over the interval from \code{a}
#' to \code{b}.  The parameter \code{m} sets the number of intervals
#' to use when evaluating.  Additional options are passed to the
#' function \code{f} when evaluating.
#'
#' @return the value of the integral
#'
#' @family integration
#' @family newton-cotes
#'
#' @examples
#' f <- function(x) { sin(x)^2 + log(x)}
#' romberg(f, 1, 10, m = 3)
#' romberg(f, 1, 10, m = 5)
#' romberg(f, 1, 10, m = 10)
#'
#' @export
romberg <- function(f, a, b, m, tab = FALSE) {
    R <- matrix(NA, nrow = m, ncol = m)
    
    R[1, 1] <- trap(f, a, b, m = 1)
    for(j in 2:m) {
        R[j, 1] <- trap(f, a, b, m = 2^(j - 1))
        for(k in 2:j) {
            k4 <- 4^(k - 1)
            R[j, k] <- k4 * R[j, k - 1] - R[j - 1, k - 1]
            R[j, k] <- R[j, k] / (k4 - 1)
        }
    }
    
    if(tab == TRUE)
        return(R)
    return(R[m, m])
}
