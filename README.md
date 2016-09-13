# Computational Methods for Numerical Analysis

[![Build Status](https://travis-ci.org/howardjp/cmna.svg?branch=master,osx)](https://travis-ci.org/howardjp/cmna)
[![Coverage Status](https://coveralls.io/repos/howardjp/cmna/badge.svg?branch=master&service=github)](https://coveralls.io/github/howardjp/cmna?branch=master)
[![Downloads from the RStudio CRAN mirror](http://cranlogs.r-pkg.org/badges/cmna)](http://cran.rstudio.com/package=cmna)

This is the R package to support _Computational Methods for Numerical
Analysis with R_ by James P. Howard, II.  This book is scheduled for
publication in 2016 and will include a variety of implementations of
numerical analysis algorithms in pure R.

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
	* More Differentiators, symdiff, rdiff)
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

## Contribution guidelines

* Use [Git Flow](http://nvie.com/posts/a-successful-git-branching-model/)
* Write unit tests using [testthat](https://github.com/hadley/testthat)
* Document functions using [roxygen2](https://github.com/yihui/roxygen2)
* Use [ZenHub](https://www.zenhub.com/) for project management on GitHub

## For more information

* [Website for CMNA](https://jameshoward.us/cmna)
* James P. Howard, II &lt;jh@jameshoward.us&gt;

