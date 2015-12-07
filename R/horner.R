#' @name horner
#' @rdname horner
#'
#' @title Horner's rule
#'
#' @description
#' Use Horner's rule to evaluate a polynomial
#'
#' @param x a vector of x values to evaluate the polynomial
#' @param betas vector of coefficients of x
#'
#' @details
#' This function implements Horner's rule for fast polynomial
#' evaluation.  The implementation expects \code{x} to be a vector of x
#' values at which to evaluate the polynomial. The parameter \code{betas}
#' is a vector of coefficients of \emph{x}.  The vector order is such
#' that the first element is the constant term, the second element is
#' the coefficient of \emph{x}, the so forth to the highest degreed
#' term.  Terms with a 0 coefficient should have a 0 element in the
#' vector.
#'
#' The function \code{rhorner} implements the the Horner algorithm
#' recursively.
#'
#' The function \code{naivepoly} implements a polynomial evaluator using
#' the straightforward algebraic approach.
#'
#' The function \code{betterpoly} implements a polynomial evaluator using
#' the straightforward algebraic approach with cached \emph{x} terms.
#' 
#' @return the value of the function at \code{x}
#'
#' @family algebra
#' 
#' @examples
#' b <- c(2, 10, 11)
#' x <- 5
#' horner(x, b)
#' b <- c(-1, 0, 1)
#' x <- c(1, 2, 3, 4)
#' horner(x, b)
#' rhorner(x, b)

#' @export
horner <- function(x, betas) {
    y <- rep(0, length(x))
    
    for(i in length(betas):1)
        y <- betas[i] + x * y
 
    return(y)
}

#' @rdname horner
#' @export
rhorner <- function(x, betas) {
    n <- length(betas)
    
    if(n == 1)
        return(betas)
    
    return(betas[1] + x * rhorner(x, betas[2:n]))
}

#' @rdname horner
#' @export
naivepoly <- function(x, betas) {
    y <- rep(0, length(x))
    
    for(i in 1:length(betas))
        y <- y + betas[i] * (x ^ (i - 1))
    
    return(y)
}

#' @rdname horner
#' @export
betterpoly <- function(x, betas) {
    y <- rep(0, length(x))
    cached.x <- 1
    
    for(i in 1:length(betas)) {
        y <- y + betas[i] * cached.x
        cached.x <- cached.x * x
    }
    
    return(y)
}
