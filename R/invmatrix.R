#' @title Invert a matrix
#'
#' @description
#' Invert the matrix using Gaussian elimination
#' 
#' @param m a matrix
#' 
#' @details
#' \code{invmatrix} invertse the given matrix using Gaussian elimination
#' and returns the result. 
#'
#' @return the inverted matrix
#'
#' @family linear
#'
#' @examples
#' A <- matrix(c(1, 2, -7, -1, -1, 1, 2, 1, 5), 3)
#' refmatrix(A)
#'
#' @export
invmatrix <- function(m) {
    count.rows <- nrow(m)
    count.cols <- ncol(m)

    if(count.rows != count.cols)
        stop("Matrix must be square")

    I = diag(count.cols)
    tmp <- cbind(m, I)
    tmp <- rrefmatrix(tmp)
    res <- tmp[, (count.cols + 1):(count.cols * 2)]
    return(res)
}
