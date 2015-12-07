#' @title Norm of a vector
#'
#' @description
#' Find the norm of a vector
#' 
#' @param b a vector
#'
#' @details
#' Find the norm of a vector
#' 
#' @return the norm
#'
#' @family linear
#'
#' @examples
#' x <- c(1, 2, 3)
#' vecnorm(x)
#'
#' @export
vecnorm <- function(b) {
    return(sqrt(sum(b^2)))
}
