#' @rdname quadratic
#' @name quadratic
#'
#' @title The quadratic equation.
#'
#' @description
#' Find the zeros of a quadratic equation.
#'
#' @param b2 the coefficient of the x^2 term
#' @param b1 the coefficient of the x term
#' @param b0 the constant term
#'
#' @details
#' \code{quadratic} and \code{quadratic2} implement the quadratic
#' equation from standard algebra in two different ways.  The
#' \code{quadratic} function is susceptible to cascading numerical error
#' and the \code{quadratic2} has reduced potential error.
#'
#' @return numeric vector of solutions to the equation
#'
#' @family algebra
#'
#' @examples
#' quadratic(1, 0, -1)
#' quadratic(4, -4, 1)
#' quadratic2(1, 0, -1)
#' quadratic2(4, -4, 1)

#' @export
quadratic <- function(b2, b1, b0) {
    t1 <- sqrt(b1^2 - 4 * b2 * b0)
    t2 <- 2 * b2

    x1 <- - (b1 + t1) / t2
    x2 <- - (b1 - t1) / t2
    return(c(x1, x2))
}

#' @rdname quadratic
#' @export
quadratic2 <- function(b2, b1, b0) {    
    t1 <- sqrt(b1^2 - 4 * b2 * b0)
    t2 <- 2 * b0

    x1 <- t2 / (-b1 - t1)
    x2 <- t2 / (-b1 + t1)

    ## Reverse the order so they come
    ## back the same as quadratic()
    return(c(x2, x1))
}
