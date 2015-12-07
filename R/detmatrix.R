#' @title Calculate the determinant of the matrix
#'
#' @description
#' Calculate the determinant of the matrix
#' 
#' @param m a matrix
#' 
#' @details
#' \code{detmatrix} calculates the determinant of the matrix given.
#'
#' @return the determinant
#'
#' @family linear
#'
#' @examples
#' A <- matrix(c(1, 2, -7, -1, -1, 1, 2, 1, 5), 3)
#' detmatrix(A)
#'
#' @export
detmatrix <- function(m) {
    if(nrow(m) != ncol(m))
        stop("Matrix must be square")
    ref.m <- refmatrix(m)
    diagonal.m <- diag(ref.m)
    result <- prod(diagonal.m)
    return(result)
}
