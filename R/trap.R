#' @title Trapezoid method
#'
#' @description
#' Use the trapezoid method to integrate a function
#'
#' @param f function to integrate
#' @param a the a-bound of integration
#' @param b the b-bound of integration
#' @param m the number of subintervals to calculate
#'
#' @details
#' The \code{trap} function uses the trapezoid method to calculate
#' the integral of the function \code{f} over the interval from
#' \code{a} to \code{b}.  The parameter \code{m} sets the
#' number of intervals to use when evaluating the trapezoids.  Additional
#' options are passed to the function \code{f} when evaluating.
#'
#' @return the value of the integral
#'
#' @family integration
#' @family newton-cotes
#'
#' @examples
#' f <- function(x) { sin(x)^2 + cos(x)^2 }
#' trap(f, -pi, pi, m = 10)
#' trap(f, -pi, pi, m = 100)
#' trap(f, -pi, pi, m = 1000)
#'
#' @export
trap <- function(f, a, b, m = 100) {
    x = seq(a, b, length.out = m + 1)
    y = f(x)

    p.area = sum((y[2:(m+1)] + y[1:m]))
    p.area = p.area * abs(b - a) / (2 * m)
    return(p.area)
}
