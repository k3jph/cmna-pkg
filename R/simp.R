#' @title Simpson's rule
#'
#' @description
#' Use Simpson's rule to integrate a function
#'
#' @param f function to integrate
#' @param a the a-bound of integration
#' @param b the b-bound of integration
#' @param m the number of subintervals to calculate
#'
#' @details
#' The \code{simp} function uses Simpson's rule to calculate the
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
#' f <- function(x) { sin(x)^2 + cos(x)^2 }
#' simp(f, -pi, pi, m = 10)
#' simp(f, -pi, pi, m = 100)
#' simp(f, -pi, pi, m = 1000)
#'
#' @export
simp <- function(f, a, b, m = 100) {
    x.ends = seq(a, b, length.out = m + 1)
    y.ends = f(x.ends)
    x.mids = (x.ends[2:(m + 1)] - x.ends[1:m]) / 2 +
        x.ends[1:m]
    y.mids = f(x.mids)

    p.area = sum(y.ends[2:(m+1)] + 4 * y.mids[1:m] +
                     y.ends[1:m])
    p.area = p.area * abs(b - a) / (6 * m)
    return(p.area)
}
