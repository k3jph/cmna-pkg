#' @title Hill climbing
#' 
#' @name hillclimbing
#' @rdname hillclimbing
#'
#' @description
#' Use hill climbing to find the global minimum
#'
#' @param f function representing the derivative of \code{f}
#' @param x an initial estimate of the minimum
#' @param h the step size
#' @param m the maximum number of iterations
#'
#' @details
#'
#' Hill climbing 
#'
#' @return the \code{x} value of the minimum found
#'
#' @family optimz
#'
#' @examples
#' f <- function(x) {   
#'     (x[1]^2 + x[2] - 11)^2 + (x[1] + x[2]^2 - 7)^2
#' }
#' hillclimbing(f, c(0,0))
#' hillclimbing(f, c(-1,-1))
#' hillclimbing(f, c(10,10))

#' @export
hillclimbing <- function(f, x, h = 1, m = 1e3) {
    n <- length(x)
    
    xcurr <- x
    ycurr <- f(x) 

    for(i in 1:m) {
        xnext <- xcurr
        i <- ceiling(runif(1, 0, n))
        xnext[i] <- rnorm(1, xcurr[i], h)
        ynext <- f(xnext)
        if(ynext < ycurr) {
            xcurr <- xnext
            ycurr <- ynext
        }
    }
    
    return(xcurr)
}

