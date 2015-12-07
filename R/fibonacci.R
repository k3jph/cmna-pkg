#' @title Fibonacci numbers
#'
#' @description
#' Return the n-th Fibonacci number
#'
#' @param n n
#'
#' @details
#' This function is recursively implements the famous Fibonacci
#' sequence.  The function returns the \code{n}th member of the
#' sequence.
#' 
#' @return the sequence element
#'
#' @family algebra
#' 
#' @examples
#' fibonacci(10)
#' 
#' @export
fibonacci <- function(n) {
    if(n == 0)
        return(0)
    if(n == 1)
        return(1)
    return(fibonacci(n - 1) + fibonacci(n - 2))
}
