#' @rdname rowops
#' @name rowops
#'
#' @title Elementary row operations
#'
#' @description
#' 
#' These are elementary operations for a matrix.  They do not presume a
#' square matrix and will work on any matrix.  They use R's internal row
#' addressing to function.
#' 
#' @param m a matrix
#' @param row a row to modify
#' @param row1 a source row
#' @param row2 a destination row
#' @param k a scaling factor
#' 
#' @details
#'
#' \code{replacerow} replaces one row with the sum of itself and the
#' multiple of another row.  \code{swaprows} swap two rows in the
#' matrix.  \code{scalerow} scales all enteries in a row by a constant.
#'
#' @return the modified matrix
#'
#' @family linear
#'
#' @examples
#' n <- 5
#' A <- matrix(sample.int(10, n^2, TRUE) - 1, n)
#' A <- swaprows(A, 2, 4)
#' A <- replacerow(A, 1, 3, 2)
#' A <- scalerow(A, 5, 10)

#' @rdname rowops
#' @export
swaprows <- function(m, row1, row2) {
    row.tmp <- m[row1,]
    m[row1,] <- m[row2,]
    m[row2,] <- row.tmp

    return(m)
}

#' @rdname rowops
#' @export
replacerow <- function(m, row1, row2, k) {
    m[row2,] <- m[row2,] + m[row1,] * k
    return(m)
}

#' @rdname rowops
#' @export
scalerow <- function(m, row, k) {
    m[row,] <- m[row,] * k
    return(m)
}

