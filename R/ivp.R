## Copyright (c) 2016-2026, James P. Howard, II <jh@jameshoward.us>
## SPDX-License-Identifier: BSD-2-Clause

#' @title Initial Value Problems
#'
#' @name ivp
#' @rdname ivp
#'
#' @description
#' Solve initial value problems for ordinary differential equations.
#'
#' @param f a function of two arguments \eqn{(x, y)} giving the derivative
#' @param x0 a finite numeric scalar giving the initial x-value
#' @param y0 a finite numeric scalar giving the initial y-value
#' @param h a positive numeric scalar giving the step size
#' @param n a positive integer giving the number of steps
#'
#' @details
#' `euler` implements the Euler method for solving ordinary differential
#' equations. `midptivp` uses the second-order Runge-Kutta (midpoint)
#' method. `rungekutta4` uses the classical fourth-order Runge-Kutta
#' method. `adamsbashforth` uses the two-step Adams-Bashforth method,
#' bootstrapping the first step with Euler's method.
#'
#' @return A data frame with columns `x` and `y`.
#'
#' @examples
#' f <- function(x, y) { y / (2 * x + 1) }
#' ivp.euler <- euler(f, 0, 1, 1/100, 100)
#' ivp.midpt <- midptivp(f, 0, 1, 1/100, 100)
#' ivp.rk4 <- rungekutta4(f, 0, 1, 1/100, 100)

#' @export
euler <- function(f, x0, y0, h, n) {
    .cmna_validate_function(f, "f")
    .cmna_validate_finite_scalar(x0, "x0")
    .cmna_validate_finite_scalar(y0, "y0")
    .cmna_validate_positive_scalar(h, "h")
    .cmna_validate_pos_integer(n, "n")

    x <- x0
    y <- y0

    for(i in 1:n) {
        y0 <- y0 + h * f(x0, y0)
        x0 <- x0 + h
        x <- c(x, x0)
        y <- c(y, y0)
    }

    return(data.frame(x = x, y = y))
}

#' @rdname ivp
#' @export
midptivp <- function(f, x0, y0, h, n) {
    .cmna_validate_function(f, "f")
    .cmna_validate_finite_scalar(x0, "x0")
    .cmna_validate_finite_scalar(y0, "y0")
    .cmna_validate_positive_scalar(h, "h")
    .cmna_validate_pos_integer(n, "n")

    x <- x0
    y <- y0

    for(i in 1:n) {
        s1 <- h * f(x0, y0)
        s2 <- h * f(x0 + h / 2, y0 + s1 / 2)
        y0 <- y0 + s2

        x0 <- x0 + h
        x <- c(x, x0)
        y <- c(y, y0)
    }

    return(data.frame(x = x, y = y))
}

#' @rdname ivp
#' @export
rungekutta4 <- function(f, x0, y0, h, n) {
    .cmna_validate_function(f, "f")
    .cmna_validate_finite_scalar(x0, "x0")
    .cmna_validate_finite_scalar(y0, "y0")
    .cmna_validate_positive_scalar(h, "h")
    .cmna_validate_pos_integer(n, "n")

    x <- x0
    y <- y0

    for(i in 1:n) {
        s1 <- h * f(x0, y0)
        s2 <- h * f(x0 + h / 2, y0 + s1 / 2)
        s3 <- h * f(x0 + h / 2, y0 + s2 / 2)
        s4 <- h * f(x0 + h, y0 + s3)
        y0 <- y0 + s1 / 6 + s2 / 3 + s3 / 3 + s4 / 6

        x0 <- x0 + h
        x <- c(x, x0)
        y <- c(y, y0)
    }

    return(data.frame(x = x, y = y))
}

#' @rdname ivp
#' @export
adamsbashforth <- function(f, x0, y0, h, n) {
    .cmna_validate_function(f, "f")
    .cmna_validate_finite_scalar(x0, "x0")
    .cmna_validate_finite_scalar(y0, "y0")
    .cmna_validate_positive_scalar(h, "h")
    .cmna_validate_pos_integer(n, "n")

    ## Quick Euler the value of x1, y1
    y1 <- y0 + h * f(x0, y0)
    x1 <- x0 + h

    x <- c(x0, x1)
    y <- c(y0, y1)
    n <- n - 1

    for(i in 1:n) {
        yn <- y1 + 1.5 * h * f(x1, y1) - .5 * h * f(x0, y0)
        xn <- x1 + h

        y0 <- y1
        x0 <- x1
        y1 <- yn
        x1 <- xn

        y <- c(y, y1)
        x <- c(x, x1)
    }

    return(data.frame(x = x, y = y))
}
