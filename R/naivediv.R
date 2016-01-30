#' @name division
#' @rdname division
#'
#' @title Algorithms for divisions
#'
#' @description
#' Algorithms for division that provide a quotient and remainder.
#'
#' @param m the dividend
#' @param n the divisor
#'
#' @details
#' The \code{naivediv} divides \code{m} by \code{n} by using repeated
#' division.  The \code{longdiv} function uses the long division
#' algorithm in binary.
#'
#' @return the quotient and remainder as a list
#'
#' @family algebra
#' 
#' @examples
#' a <- floor(runif(1, 1, 1000))
#' b <- floor(runif(1, 1, 100))
#' naivediv(a, b)
#' longdiv(a, b)
#' 
#' @export
naivediv <- function(m, n) {
    quot <- 0
    r <- m
    
    if(n == 0)
        stop("Attempted division by 0")

    while(r >= n) {
        quot <- quot + 1
        r <- r - n
    }
    
    return(list(quot = quot, r = r))
}

#' @rdname division
#' @export
longdiv <- function(m, n) {
    quot <- 0
    r <- 0

    if(n == 0)
        stop("Attempted division by 0")
 
    for(i in 31:0) {
        r <- bitwShiftL(r, 1)
        r <- r + bitwAnd(bitwShiftR(m, i), 1)
        if(r >= n) {
            r <- r - n
            quot <- quot + bitwShiftL(1, i)
        }
    }
    
    return(list(quot = quot, r = r))
}
