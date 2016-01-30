#' @name gdls
#'
#' @title Least squares with graident descent
#'
#' @description
#' Solve least squares with graident descent
#'
#' @param A a square matrix representing the coefficients of a linear system
#' @param b a vector representing the right-hand side of the linear system
#' @param alpha the learning rate
#' @param tol the expected error tolerance
#' @param m the maximum number of iterations
#'
#' @details
#'
#' \code{gdls} solves a linear system using gradient descent.
#'
#' @return the modified matrix
#'
#' @family linear
#'
#' @examples
#' head(b <- iris$Sepal.Length)
#' head(A <- matrix(cbind(1, iris$Sepal.Width, iris$Petal.Length, iris$Petal.Width), ncol = 4))
#' gdls(A, b, alpha = 0.05, m = 10000)
#'
#' @export
gdls <- function(A, b, alpha = 0.05, tol = 1e-6, m = 1e5) {
    iter <- 0
    n <- ncol(A)
    theta <- matrix(rep(0, n))
    oldtheta = theta + 10 * tol

    while(vecnorm(oldtheta - theta) > tol) {
        if((iter <- iter + 1) > m)
            return(theta)
        e <- (A %*% theta - b)
        d <- (t(A) %*% e) / length(b)
        oldtheta <- theta
        theta <- theta - alpha * d
    }

    return(theta)
}
