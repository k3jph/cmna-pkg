#' @title Cholesky Decomposition
#'
#' @description
#' Decompose a matrix into the Cholesky
#' 
#' @param m a matrix
#' 
#' @details
#' \code{choleskymatrix} decomposes the matrix \code{m} into the LU
#' decomposition, such that m == L %*% L*.
#'
#' @return the matrix L
#'
#' @family linear
#'
#' @examples
#' A <- matrix(c(5,1,2,1,9,3,2,3,7),3)
#' choleskymatrix(m)
#'
#' @export
choleskymatrix <- function(m) {
    count.rows <- nrow(m)
    count.cols <- ncol(m)

    
    L = diag(0, count.rows)
    for(i in 1:count.rows) {
        for(k in 1:i) {
            p.sum <- 0
            for(j in 1:k)
                p.sum <- p.sum + L[j, i] * L[j, k]
            if(i == k)
                L[k, i] <- sqrt(m[i, i] - p.sum)
            else
                L[k, i] <- (m[k, i] - p.sum) / L[k, k]
        }
    }
    return(L)
}
