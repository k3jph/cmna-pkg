#' @title Simpson's 3/8 rule
#'
#' @description
#' Use Simpson's 3/8 rule to integrate a function
#'
#' @param f function to integrate
#' @param a the a-bound of integration
#' @param b the b-bound of integration
#' @param m the number of subintervals to calculate
#'
#' @details
#' The \code{simp38} function uses Simpson's 3/8 rule to calculate the
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
#' f <- function(x) { sin(x)^2 + log(x) }
#' simp38(f, 1, 10, m = 10)
#' simp38(f, 1, 10, m = 100)
#' simp38(f, 1, 10, m = 1000)
#'
#' @export
simp38 <- function(f, a, b, m = 100) {
    x.ends = seq(a, b, length.out = m + 1)
    y.ends = f(x.ends)
    x.midh = (2 * x.ends[2:(m + 1)] + x.ends[1:m]) / 3
    x.midl = (x.ends[2:(m + 1)] + 2 * x.ends[1:m]) / 3
    y.midh = f(x.midh)
    y.midl = f(x.midl)
    
    p.area = sum(y.ends[2:(m+1)] + 3 * y.midh[1:m] + 3 *
                     y.midl[1:m] + y.ends[1:m])
    p.area = p.area * abs(b - a) / (8 * m)
    return(p.area)
}
