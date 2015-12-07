#' @title Gini coefficients
#'
#' @description
#'
#' Calculate the Gini coefficient from quintile data
#' 
#' @param L vector of percentages at 20th, 40th, 60th, and 80th
#' percentiles
#'
#' @details
#'
#' Calculate the Gini coefficient given the quintile data.
#' 
#' @return the estimated Gini coefficient
#'
#' @family integration
#' @family newton-cotes
#'
#' @examples
#' L <- c(4.3, 9.8, 15.4, 22.7)
#' giniquintile(L)
#'
#' @references
#'
#' Leon Gerber, "A Quintile Rule for the Gini Coefficient",
#' \emph{Mathematics Magazine}, 80:2, April 2007.
#' 
#' @export
giniquintile <- function(L) {
    x <- c(.2, .4, .6, .8)
    L <- x - cumsum(L / 100)
    
    return(25 / 144 * (3*L[1] + 2*L[2] + 2*L[3] + 3*L[4]))
}
