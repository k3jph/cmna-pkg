#' @title Nearest interpolation
#'
#' @description
#' Find the nearest neighbor for a set of data points
#' 
#' @param p matrix of variable values, each row is a data point
#' @param y vector of values, each entry corresponds to one row in \code{p}
#' @param q vector of variable values, each entry corresponds to one column of \code{p}
#' 
#' @details
#' \code{nn} finds the n-dimensional nearest neighbor for given datapoint
#'
#' @return an interpolated value for \var{q}
#' 
#' @family interp
#'
#' @examples
#' p <- matrix(floor(runif(100, 0, 9)), 20)
#' y <- floor(runif(20, 0, 9))
#' q <- matrix(floor(runif(5, 0, 9)), 1)
#' nn(p, y, q)
#' 
#' @export
nn <- function(p, y, q) {
    if(ncol(p) != ncol(q))
        stop("p and q must have same number of columns")
    
    ## Repeat the rows of q to simplfy the  calculation
    qprime <- t(matrix(rep(q, nrow(p)), ncol(p)))
    d <- sqrt(rowSums((p - qprime)^2))
    return(y[which.min(d)])
}
