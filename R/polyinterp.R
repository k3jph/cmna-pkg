#' @title Polynomial interpolation
#'
#' @description
#' Finds a polynomial function interpolating the given points
#' 
#' @param x a vector of x values
#' @param y a vector of y values
#' 
#' @details
#' \code{polyinterp} finds a polynomial that interpolates the given points.  
#'
#' @return a polynomial equation's coefficients
#'
#' @family interp
#' @family algebra
#'
#' @examples
#' x <- c(1, 2, 3)
#' y <- x^2 + 5 * x - 3
#' f <- polyinterp(x, y)
#' 
#' @export
polyinterp <- function(x, y) {
    if(length(x) != length(y))
        stop("Length of x and y vectors must be the same")
    
    n <- length(x) - 1
    vandermonde <- rep(1, length(x))
    for(i in 1:n) {
        xi <- x^i
        vandermonde <- cbind(xi, vandermonde)
    }
    beta <- solve(vandermonde, y)
    
    names(beta) <- NULL
    return(rev(beta))
}
