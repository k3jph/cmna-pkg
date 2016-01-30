#' @title Gaussian integration method driver
#'
#' @description
#' Use the Gaussian method to evaluate integrals
#'
#' @param f function to integrate
#' @param m number of evaluation points
#' @param x list of evaluation points
#' @param w list of weights
#'
#' @details
#' The \code{gaussint} function uses the Gaussian integration to
#' evaluate an integral.  The function itself is a driver and expects
#' the integration points and associated weights as options.
#' 
#' @return the value of the integral
#'
#' @family integration
#'
#' @examples
#' w = c(1, 1)
#' x = c(-1 / sqrt(3), 1 / sqrt(3))
#' f <- function(x) { x^3 + x + 1 }
#' gaussint(f, x, w)
#'
#' @export
gaussint <- function(f, x, w) {
    y <- f(x)
    
    return(sum(y * w))
}

#' @rdname gaussint
#' @export
gauss.legendre <- function(f, m = 5) {
    p <- paste("gauss.legendre.", m, sep = "")
    tryCatch(data(list = p, envir = environment()),
             warning = stop)
    params <- eval(parse(text = p))
    
    return(gaussint(f, params$x, params$w))
}

#' @rdname gaussint
#' @export
gauss.laguerre <- function(f, m = 5) {
  p <- paste("gauss.laguerre.", m, sep = "")
  tryCatch(data(list = p, envir = environment()),
           warning = stop)
  params <- eval(parse(text = p))
  
  return(gaussint(f, params$x, params$w))
}

#' @rdname gaussint
#' @export
gauss.hermite <- function(f, m = 5) {
  p <- paste("gauss.hermite.", m, sep = "")
  tryCatch(data(list = p, envir = environment()),
           warning = stop)
  params <- eval(parse(text = p))
  
  return(gaussint(f, params$x, params$w))
}
