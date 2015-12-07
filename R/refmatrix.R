#' @name refmatrix
#' @rdname refmatrix
#'
#' @title Matrix to Row Echelon Form
#'
#' @description
#' Transform a matrix to row echelon form.
#' 
#' @param m a matrix
#' @param A a square matrix representing the coefficients of a linear
#' system in \code{solvematrix}
#' @param b a vector representing the right-hand side of the linear
#' system in \code{solvematrix}
#' 
#' @details
#' \code{refmatrix} reduces a matrix to row echelon form.  This is not a
#' reduced row echelon form, though that can be easily calculated from
#' the diagonal.  This function works on non-square matrices.
#'
#' \code{rrefmatrix} returns the reduced row echelon matrix.
#'
#' \code{solvematrix} solves a linear system using \code{rrefmatrix}.
#'
#' @return the modified matrix
#'
#' @family linear
#'
#' @examples
#' A <- matrix(c(1, 2, -7, -1, -1, 1, 2, 1, 5), 3)
#' refmatrix(A)
#'
#' @export
refmatrix <- function(m) {
    count.rows <- nrow(m)
    count.cols <- ncol(m)
    piv <- 1
    
    for(row.curr in 1:count.rows) {
        if(piv <= count.cols) {
            i <- row.curr
            while(m[i, piv] == 0 && i < count.rows) {
                i <- i + 1
                if(i > count.rows) {
                    i <- row.curr
                    piv <- piv + 1
                    if(piv > count.cols)
                        return(m)
                }
            }
            if(i != row.curr) 
                m <- swaprows(m, i, row.curr)
            for(j in row.curr:count.rows)
                if(j != row.curr) {
                    k <- m[j, piv] / m[row.curr, piv]
                    m <- replacerow(m, row.curr, j, -k)
                }
            piv <- piv + 1
        }
    }
    return(m)
}

#' @rdname refmatrix
#' @export
rrefmatrix <- function(m) {
    count.rows <- nrow(m)
    count.cols <- ncol(m)
    piv <- 1
    
    for(row.curr in 1:count.rows) {
        if(piv <= count.cols) {
            i <- row.curr
            while(m[i, piv] == 0 && i < count.rows) {
                i <- i + 1
                if(i > count.rows) {
                    i <- row.curr
                    piv <- piv + 1
                    if(piv > count.cols)
                        return(m)
                }
            }
            if(i != row.curr) 
                m <- swaprows(m, i, row.curr)
            piv.val <- m[row.curr, piv]
            m <- scalerow(m, row.curr, 1 / piv.val)
            for(j in 1:count.rows)
                if(j != row.curr) {
                    k <- m[j, piv] / m[row.curr, piv]
                    m <- replacerow(m, row.curr, j, -k)
                }
            piv <- piv + 1
        }
    }
    return(m)
}

#' @rdname refmatrix
#' @export
solvematrix <- function(A, b) {

    m <- cbind(A, b)
    m <- rrefmatrix(m)
    x <- m[, ncol(m)]

    return(x)
}
