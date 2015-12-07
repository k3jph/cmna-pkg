#' @title Natural cubic spline interpolation
#'
#' @description
#' Finds a piecewise linear function that interpolates the data points
#' 
#' @param x a vector of x values
#' @param y a vector of y values
#' 
#' @details
#' \code{cubicspline} finds a piecewise cubic spline function that
#' interpolates the data points.  For each x-y ordered pair. The function will
#' return a list of four vectors representing the coefficients.
#'
#' @return a list of coefficient vectors
#'
#' @family interp
#' @family algebra
#'
#' @examples
#' x <- c(1, 2, 3)
#' y <- c(2, 3, 5)
#' f <- cubicspline(x, y)
#' 
#' x <- c(-1, 1, 0, -2)
#' y <- c(-2, 2, -1, -1)
#' f <- cubicspline(x, y)
#' 
#' @export
cubicspline <- function(x, y) {
    n <- length(x)
    dvec <- bvec <- avec <- rep(0, n - 1)
    vec <- rep(0, n)
    deltax <- deltay <- rep(0, n - 1)
    
    ##  Find delta values and the A-vector
    for(i in 1:(n - 1)) {
        avec[i] <- y[i]
        deltax[i] = x[i + 1] - x[i]
        deltay[i] = y[i + 1] - y[i]
    }
    
    ##  Assemble a tridiagonal matrix of coefficients
    Au <- c(0, deltax[2:(n-1)])
    Ad <- c(1, 2 * (deltax[1:(n-2)] + deltax[2:(n-1)]), 1)
    Al <- c(deltax[1:(n-2)], 0)
    
    vec[0] <- vec[n] <- 0
    for(i in 2:(n - 1))
        vec[i] <- 3 * (deltay[i] / deltax[i] -
                           deltay[i-1] / deltax[i-1])
    
    cvec <- tridiagmatrix(Al, Ad, Au, vec)
    
    ##  Compute B- and D-vectors from the C-vector
    for(i in 1:(n-1)) {
        bvec[i] <- (deltay[i] / deltax[i]) -
            (deltax[i] / 3) * (2 * cvec[i] + cvec[i + 1])
        dvec[i] <- (cvec[i+1] - cvec[i]) / (3 * deltax[i])
    }
    
    return(list(a = avec, b = bvec,
                c = cvec[1:(n - 1)], d = dvec))
}

