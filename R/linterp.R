#' @title Linear interpolation
#'
#' @description
#' Finds a linear function between two points
#' 
#' @param x1 x value of the first point
#' @param y1 y value of the first point
#' @param x2 x value of the second point
#' @param y2 y value of the second point
#' 
#' @details
#' \code{linterp} finds a linear function  between two points.  
#'
#' @return a linear equation's coefficients
#'
#' @family interp
#' @family algebra
#'
#' @examples
#' f <- linterp(3, 2, 7, -2)
#' 
#' @export
linterp <- function(x1, y1, x2, y2) {
    m <- (y2 - y1) / (x2 - x1)
    b <- y2 - m * x2

    ## Convert into a form suitable for horner()
    return(c(b, m))
}

