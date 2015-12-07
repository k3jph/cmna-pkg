#' @name revolution-solid
#' @rdname revolution-solid
#'
#' @title Volumes of solids of revolution
#'
#' @description
#' Find the volume of a solid of revolution
#' 
#' @param f function of revolution
#' @param a lower-bound of the solid
#' @param b upper-bound of the solid
#'
#' @details
#' 
#' The functions \code{discmethod} and \code{shellmethod} implement the
#' algorithms for finding the volume of solids of revolution.  The
#' \code{discmethod} function is suitable for volumes revolved around
#' the \code{x}-axis and the \code{shellmethod} function is suitable for
#' volumes revolved around the \code{y}-axis.
#'
#' @return the volume of the solid
#'
#' @family integration
#'
#' @examples
#' f <- function(x) { x^2 }
#' shellmethod(f, 1, 2)
#' discmethod(f, 1, 2)
#' 
#' @export
shellmethod <- function(f, a, b) {
    solid <- function(x) { return(x * f(x)) }
    
    return(2 * pi * trap(solid, a, b))
}

#' @rdname revolution-solid
#' @export
discmethod <- function(f, a, b) {
    solid <- function(x) { return(pi * (f(x))^2) }
  
    return(midpt(solid, a, b))
}
