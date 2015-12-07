#' @title Wilkinson's Polynomial
#'
#' @description
#' Wilkinson's polynomial
#'
#' @param x the \code{x}-value
#' @param w the number of terms in the polynomial
#' 
#' @details
#' Wilkinson's polynomail is a terrible joke played on numerical
#' analysis.  By tradition, the function is f(x) = (x - 1)(x - 2)...(x -
#' 20), giving a function with real roots at each integer from 1 to 20.
#' This function is generalized and allows for \code{n} and the function
#' value is f(x) = (x - 1)(x - 2)...(x - n).  The default of \code{n} is
#' 20.
#' 
#' @return the value of the function at \code{x}
#'
#' @family polynomials
#'
#' @examples
#' wilkinson(0)
#' 
#' @export
wilkinson <- function(x, w = 20) {

    if(w == 1)
        return(x - 1)
    return((x - w) * wilkinson(x, w - 1))
}
