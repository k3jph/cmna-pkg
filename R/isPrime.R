#' @title Test for Primality
#'
#' @description
#' Test the number given for primality.
#'
#' @param n n
#'
#' @details
#' This function tests \code{n} if it is prime through repeated division
#' attempts.  If a match is found, by finding a remainder of 0,
#' \code{FALSE} is returned.
#' 
#' @return boolean TRUE if \code{n} is prime, FALSE if not
#'
#' @family algebra
#' 
#' @examples
#' isPrime(37)
#' isPrime(89)
#' isPrime(100)
#' 
#' @export
isPrime <- function(n) {
    if(n == 2)
        return(TRUE)
    
    for(i in 2:sqrt(n))
        if(n %% i == 0)
            return(FALSE)
    
    return(TRUE)
}
