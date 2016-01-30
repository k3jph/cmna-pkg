#' @title Golden Section Search
#'
#' @name goldsect
#' @rdname goldsect
#' 
#' @description
#' Use golden section search to find local extrema
#'
#' @param f function to integrate
#' @param a the a bound of the search region
#' @param b the b bound of the search region
#' @param tol the error tolerance
#' @param m the maximum number of iterations
#' 
#' @details
#'
#' The golden section search  method functions by repeatedly dividing the interval
#' between \code{a} and \code{b} and will return when the
#' interval between them is less than \code{tol}, the error tolerance.
#' However, this implementation also stop if after \code{m}
#' iterations.
#' 
#' @return the \code{x} value of the minimum found
#'
#' @family optimz
#'
#' @examples
#' f <- function(x) { x^2 - 3 * x + 3 }
#' goldsectmin(f, 0, 5)
#'
#' @export
goldsectmin <- function(f, a, b, tol = 1e-3, m = 100) {
    iter <- 0
    phi <- (sqrt(5) - 1) / 2
    
    a.star <- b - phi * abs(b - a)
    b.star <- a + phi * abs(b - a)
    
    while (abs(b - a) > tol) {
        iter <- iter + 1
        if (iter > m)
            break
        
        if(f(a.star) < f(b.star)) {
            b <- b.star
            b.star <- a.star
            a.star <- b - phi * abs(b - a)
        } else {
            a <- a.star
            a.star <- b.star
            b.star <- a + phi * abs(b - a)
        }
    }
    
    return((a + b) / 2)
}

#' @rdname goldsect
#' @export
goldsectmax <- function(f, a, b, tol = 1e-3, m = 100) {
    iter <- 0
    phi <- (sqrt(5) - 1) / 2
    
    a.star <- b - phi * abs(b - a)
    b.star <- a + phi * abs(b - a)
    
    while (abs(b - a) > tol) {
        iter <- iter + 1
        if (iter > m)
            break
        
        if(f(a.star) > f(b.star)) {
            b <- b.star
            b.star <- a.star
            a.star <- b - phi * abs(b - a)
        } else {
            a <- a.star
            a.star <- b.star
            b.star <- a + phi * abs(b - a)
        }
    }
    
    return((a + b) / 2)
}
