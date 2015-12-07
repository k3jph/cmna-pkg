#' @title rectangle method
#'
#' @description
#' Use the rectangle method to integrate a function
#'
#' @param f function to integrate
#' @param a the a-bound of integration
#' @param b the b-bound of integration
#' @param m the number of subintervals to calculate
#'
#' @details
#' The \code{midpt} function uses the rectangle method to calculate
#' the integral of the function \code{f} over the interval from
#' \code{a} to \code{b}.  The parameter \code{m} sets the number
#' of intervals to use when evaluating the rectangles.  Additional
#' options are passed to the function \code{f} when evaluating.
#'
#' @return the value of the integral
#'
#' @family integration
#' @family newton-cotes
#'
#' @examples
#' f <- function(x) { sin(x)^2 + cos(x)^2 }
#' midpt(f, -pi, pi, m = 10)
#' midpt(f, -pi, pi, m = 100)
#' midpt(f, -pi, pi, m = 1000)
#'
#' @export
midpt <- function(f, a, b, m = 100) {
    nwidth = (b - a) / m
    x = seq(a, b - nwidth, length.out = m) + nwidth / 2
    y = f(x)

    area = sum(y) * abs(b - a) / m
    return(area)
}

