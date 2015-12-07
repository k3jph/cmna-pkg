#' @rdname bezier
#' @name bezier
#' 
#' @title Bezier curves
#'
#' @description
#' Find the quadratic and cubic Bezier curve for the given points
#' 
#' @param x a vector of x values
#' @param y a vector of y values
#' @param t a vector of t values for which the curve will be computed
#' 
#' @details \code{qbezier} finds the quadratic Bezier curve for the
#' given three points and \code{cbezier} finds the cubic Bezier curve
#' for the given four points.  The curve will be computed at all values
#' in the vector \code{t} and a list of x and y values returned.
#'
#' @return a list composed of an x-vector and a y-vector
#'
#' @family interp
#'
#' @examples
#' x <- c(1, 2, 3)
#' y <- c(2, 3, 5)
#' f <- qbezier(x, y, seq(0, 1, 1/100))
#' 
#' x <- c(-1, 1, 0, -2)
#' y <- c(-2, 2, -1, -1)
#' f <- cbezier(x, y, seq(0, 1, 1/100))
#'
#' @rdname bezier
#' @export
qbezier <- function(x, y, t) {
    if(length(x) != 3 || length(y) != 3)
        error("x and y must contain exactly 3 values")
    
    newx <- (1-t)^2 * x[1] + 2 * (1-t) * t * x[2] +
        t^2 * x[3]
    newy <- (1-t)^2 * y[1] + 2 * (1-t) * t * y[2] +
        t^2 * y[3]

    return(list(x = newx, y = newy))
}

#' @rdname bezier
#' @export
cbezier <- function(x, y, t) {
    if(length(x) != 4 || length(y) != 4)
        error("x and y must contain exactly 4 values")

    newx <- (1-t)^3 * x[1] + 3 * (1-t)^2 * t * x[2] +
        3 * (1-t) * t^2 * x[3] + t^3 * x[4]
    newy <- (1-t)^3 * y[1] + 3 * (1-t)^2 * t * y[2] +
        3 * (1-t) * t^2 * y[3] + t^3 * y[4]

    return(list(x = newx, y = newy))
}
