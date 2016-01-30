#' @title Himmelblau Function
#'
#' @description
#' Generate the Himmelblau function
#'
#' @param x a vector of \code{x}-values
#' 
#' @details
#' Generate the Himmelblau function
#' 
#' @return the value of the function at \code{x}.
#'
#' @export
himmelblau <- function(x) {
  (x[1]^2 + x[2] - 11)^2 + (x[1] + x[2]^2 - 7)^2
}
