#' @rdname summation
#' @name summation
#'
#' @title Two summing algorithms
#'
#' @description
#' Find the sum of a vector
#' 
#' @param x a vector of numbers to be summed
#'
#' @details
#'
#' \code{naivesum} calculates the sum of a vector by keeping a counter
#' and repeatedly adding the next value to the interim sum.
#' \code{kahansum} uses Kahan's algorithm to capture the low-order
#' precision loss and ensure that the loss is reintegrated into the
#' final sum.  \code{pwisesum} is a recursive implementation of the
#' piecewise summation algorithm that divides the vector in two and adds
#' the individual vector sums for a result.
#'
#' @return the sum
#'
#' @family intro
#'
#' @examples
#' l <- 1:10^6
#' n <- sample(l, 1)
#' bound <- sample(l, 2)
#' bound.u <- max(bound) - 10^6 / 2
#' bound.l <- min(bound) - 10^6 / 2
#' x <- runif(n, bound.l, bound.u)
#' naivesum(x)
#' kahansum(x)
#' pwisesum(x)

#' @rdname summation
#' @export
naivesum <- function(x) {
    s <- 0
    n <- length(x)

    for(i in 1:n)
        s <- s + x[i]
    return(s)
}

#' @rdname summation
#' @export
kahansum <- function(x) {
    comp <- s <- 0
    n <- length(x)

    for(i in 1:n) {
        y <- x[i] - comp
        t <- x[i] + s
        comp <- (t - s) - y
        s <- t
    }
    return(s)
}

#' @rdname summation
#' @export
pwisesum <- function(x) {
    n <- length(x)

    if(n == 1)
        return(x)
    m = floor(n / 2)
    return(pwisesum(x[1:m]) + pwisesum(x[(m + 1):n]))
}
