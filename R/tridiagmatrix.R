#' @title Solve a tridiagonal matrix 
#'
#' @description
#' use the tridiagonal matrix algorithm to solve a tridiagonal matrix
#' 
#' @param d vector of entries on the main diagonal
#' @param l vector of entries below the main diagonal
#' @param u vector of entries above the main diagonal
#' @param b vector of the right-hand side of the linear system
#' 
#' @details
#' \code{tridiagmatrix} uses the tridiagonal matrix algorithm to solve a
#' tridiagonal matrix.
#' 
#' @return the solution vector
#'
#' @family linear
#'
#' @export
tridiagmatrix <- function(l, d, u, b) {
    n <- length(d)
    l <- c(NA, l)
    
    ##  The forward sweep
    u[1] <- u[1] / d[1]
    b[1] <- b[1] / d[1]
    for(i in 2:(n - 1)) {
        u[i] <- u[i] / (d[i] - l[i] * u[i - 1])
        b[i] <- (b[i] - l[i] * b[i - 1]) /
            (d[i] - l[i] * u[i - 1])
    }
    b[n] <- (b[n] - l[n] * b[n - 1]) /
        (d[n] - l[n] * u[n - 1])
    
    ##  The backward sweep
    x <- rep.int(0, n)
    x[n] <- b[n]
    for(i in (n - 1):1)
        x[i] <- b[i] - u[i] * x[i + 1]
    
    return(x)
}
