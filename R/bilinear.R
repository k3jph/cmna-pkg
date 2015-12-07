#' @title Bilinear interpolation
#'
#' @description
#' Finds a bilinear interpolation bounded by four points
#' 
#' @param x vector of two x values representing \code{x_1} and \code{x_2}
#' @param y vector of two y values representing \code{y_1} and \code{y_2}
#' @param z 2x2 matrix if \code{z} values
#' @param newx vector of new \code{x} values to interpolate
#' @param newy vector of new \code{y} values to interpolate
#' 
#' @details
#' \code{bilinear} finds a bilinear interpolation bounded by four corners
#'
#' @return a vector of interpolated z values at (\code{x}, \code{y})
#' 
#' @family interp
#' @family algebra
#'
#' @examples
#' x <- c(2, 4)
#' y <- c(4, 7)
#' z <- matrix(c(81, 84, 85, 89), nrow = 2)
#' newx <- c(2.5, 3, 3.5)
#' newy <- c(5, 5.5, 6)
#' bilinear(x, y, z, newx, newy)
#' 
#' @export
bilinear <- function(x, y, z, newx, newy) {

    ## Find intermediate values along the x-axis, first
    z1 <- (x[2] - newx) * z[1,1] + (newx - x[1]) * z[1,2]
    z1 <- z1 / (x[2] - x[1])
    z2 <- (x[2] - newx) * z[2,1] + (newx - x[1]) * z[2,2]
    z2 <- z2 / (x[2] - x[1])

    ## Then interpolate along the y-axis
    z <- (y[2] - newy) * z1 + (newy - y[1]) * z2
    z <- z / (y[2] - y[1])
    
    return(z)
}

