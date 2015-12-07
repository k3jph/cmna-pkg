#' @title Piecewise linear interpolation
#'
#' @description
#' Finds a piecewise linear function that interpolates the data points
#' 
#' @param x a vector of x values
#' @param y a vector of y values
#' 
#' @details
#' \code{pwiselinterp} finds a piecewise linear function that
#' interpolates the data points.  For each x-y ordered pair, there
#' function finds the unique line interpolating them.  The function will
#' return a data.frame with three columns.
#'
#' The column \code{x} is the upper bound of the domain for the given
#' piece.  The columns \code{m} and \code{b} represent the coefficients
#' from the y-intercept form of the linear equation, y = mx + b.
#'
#' The matrix will contain length(x) rows with the first row having m
#' and b of NA.
#'
#' @return a matrix with the linear function components
#'
#' @family interp
#' @family algebra
#'
#' @examples
#' x <- c(5, 0, 3)
#' y <- c(4, 0, 3)
#' f <- pwiselinterp(x, y)
#' 
#' @export
pwiselinterp <- function(x, y) {
    n <- length(x) - 1

    y <- y[order(x)]
    x <- x[order(x)]

    mvec <- bvec <- c()
    
    for(i in 1:n) {
        p <- linterp(x[i], y[i], x[i + 1], y[i + 1])
        mvec <- c(mvec, p[2])
        bvec <- c(bvec, p[1])
    }
    
    return(list(m = mvec, b = bvec))
}
