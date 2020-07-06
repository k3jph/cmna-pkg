# Computational Methods for Numerical Analysis

[![Build Status](https://travis-ci.org/k3jph/cmna-pkg.svg?branch=master)](https://travis-ci.org/k3jph/cmna-pkg)
[![Coverage Status](https://coveralls.io/repos/github/k3jph/cmna-pkg/badge.svg?branch=develop)](https://coveralls.io/github/k3jph/cmna-pkg?branch=develop)
[![codecov](https://codecov.io/gh/k3jph/cmna-pkg/branch/master/graph/badge.svg)](https://codecov.io/gh/k3jph/cmna-pkg)
[![Downloads from the RStudio CRAN mirror](https://cranlogs.r-pkg.org/badges/cmna)](https://cran.r-project.org/package=cmna)
[![Package DOI](https://img.shields.io/badge/Package_DOI-10.5281%2Fzenodo.3249230-blue.svg)](https://doi.org/10.5281/zenodo.3249230)
[![Book DOI](https://img.shields.io/badge/Book_DOI-10.1201%2F9781315120195-blue.svg)](https://doi.org/10.1201/9781315120195)

This is the R package to support _Computational Methods for Numerical
Analysis with R_ by James P. Howard, II.

_Computational Methods for Numerical Analysis with R_ is an overview
of traditional numerical analysis topics presented using R. This
guide shows how common functions from linear algebra, interpolation,
numerical integration, optimization, and differential equations can
be implemented in pure R code. Every algorithm described is given
with a complete function implementation in R, along with examples
to demonstrate the function and its use.

_Computational Methods for Numerical Analysis with R_ with R is
intended for those who already know R, but are interested in learning
more about how the underlying algorithms work. As such, it is
suitable for statisticians, economists, and engineers, and others
with a computational and numerical background.

## Algorithms included

* Elementary and Example Algorithms
  * Polynomial Expansion
    * Naive (naivepoly)
	* Cached Naive (betterpoly)
	* Horner's Method (horner, rhorner)
  * Summation
    * Naive Summation (naivesum)
    * Kahan Summation (kahansum)
  * Division
    * Naive Division (naivediv)
    * Long Division (longdiv)
  * Miscellaneous
    * Naive Primality tester (isPrime)
	* Nth Root (nthroot)
	* Quadratic Formula (quadratic, quadratic2)
  * Samples
    * Fibbonaci (fibonacci)
	* Wilinson's Polynomial (wilkinson)
    * Himmelblau (himmelblau)
* Linear Algebra
  * Row/Vector Operations
    * Row Replacement (replacerow)
	* Scale Row (scalerow)
	* Swap Rows (swaprows)
	* Norm of a Vector (vecnorm)
  * Elementary Functions
    * Determinant (detmatrix)
	* Matrix Inverse (invmatrix)
	* Row-Echelon Form (refmatrix)
	* Reduced Row-Echelon Form (rrefmatrix)
	* Solve a Matrix, Using Row Reduction (solvematrix)
  * Decompositions
    * Cholesky Decomposition (choleskymatrix)
	* LU Decomposition (lumatrix)
  * Iterative Methods
    * Conjugate Gradient (cgmmatrix)
	* Gauss Seidel (gaussseidel)
	* Jacobi (jacobi)
  * Specialty Methods
    * Tridiagonal Matrix Solver (tridiagmatrix)
* Interpolation and Extrapolation
  * Polynomial Interpolation
    * Liner Interpolation (linterp)
	* Polynomial Interpolation (polyinterp)
  * Splines
    * Piecewise Linear (pwiselinterp)
    * Cubic Spline (cubicspline)
  * Bezier
    * Quadratic Bezier (qbezier)
    * Cubic Bezier (cbezier)
  * Multidimensional Interpolaters
    * Bilinear (bilinear)
	* Nearest Neighbor (nn)
  * Applications
    * Image Resizing (resizeImageNN, resizeImageBL)
* Differentiation
  * Finite Differences
    * One-Step (findiff)
	* More Differentiators (symdiff, rdiff)
	* Second Derivative (findiff2)
* Numerical Integration
  * Newton-Cotes
	* Midpoint Method (midpt)
	* Trapezoid Method (trap)
	* Simpson's Rule (simp)
	* Simpson's 3/8s Rule (simp38)
  * Gaussian Integration
    * Driver (gaussint)
	* Specific forms (gauss.hermite, gauss.laguerre, gauss.legendre)
  * Adaptive Integrators
    * Recursive Adaptive (adaptint)
	* Romberg (romberg)
  * Monte Carlo
    * Monte Carlo Integration, 1D (mcint)
	* Monte Carlo Integration, 2D (mcint2)
  * Applications
    * Shell Method for Revolved Volume (shellmethod)
    * Disc Method for Revolved Volume (discmethod)
	* Gini Coefficient (giniquintile)
* Root Finding
  * Bisection Method (bisection)
  * Newton's Method (newton)
  * Secant Method (secant)
* Optimization
  * Continuous
    * Golden Section (goldsectmax, goldsectmin)
    * Gradient Descent (gd, gdls, gradasc, graddsc)
	* Hill Climbing (hillclimbing)
	* Simulated Annealing (sa)
  * Discrete
    * Traveling Salesperson Problem (tspsa)
* Differential Equations
  * Initial Value Problems
    * Euler Method (euler)
	* Midpoint Method (midptivp)
	* Fouth-Order Runge-Kutta (rungekutta4)
    * Adams-Bashforth (adamsbashforth)
  * Systems of Differential Equations
    * Euler Method (eulersys)
  * Partial Differential Equations
    * Heat Equation, 1D (heat)
	* Wave Equation, 1D (wave)
  * Applications
    * Boundary Value Problems (bvpexample, bvpexample10)

## Dependencies

* testthat
* roxygen2
* markdown

## Contribution guidelines

* Use [Git Flow](http://nvie.com/posts/a-successful-git-branching-model/)
* Write unit tests using [testthat](https://github.com/hadley/testthat)
* Document functions using [roxygen2](https://github.com/yihui/roxygen2)

## For more information

* [Website for CMNA](https://jameshoward.us/cmna/)
* James P. Howard, II <<jh@jameshoward.us>>
