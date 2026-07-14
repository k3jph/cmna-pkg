# CMNA R Package Roadmap

This document describes why `cmna-pkg` is being modernized, what CMNA 2.0 is intended to become, and the order in which the work should proceed. The companion [architecture document](ARCHITECTURE.md) defines the technical boundaries and design rules used to carry out this roadmap.

## Purpose

`cmna-pkg` is the R implementation supporting *Computational Methods for Numerical Analysis with R*. Its defining purpose is educational: numerical methods are implemented in readable, inspectable R so that a reader can understand the algorithm rather than merely call an optimized black-box routine.

The original package covers a broad numerical-analysis curriculum, including elementary algorithms, linear algebra, interpolation, differentiation, integration, root finding, optimization, and differential equations. That breadth remains valuable, but the code and package infrastructure were created across an earlier generation of R practice. CMNA 2.0 is the systematic modernization of that body of work for a second edition of the book.

The objective is not to turn CMNA into a replacement for specialized numerical libraries. It is to make each implementation:

- mathematically faithful;
- explicit about its contract and failure modes;
- safe against common numerical and programming errors;
- thoroughly tested;
- documented well enough to stand beside the corresponding explanation in the book; and
- consistent with the companion Emacs Lisp implementation where the underlying mathematics should agree.

## Why we are here

The package has two simultaneous responsibilities.

First, it is executable instructional material. A function in CMNA is part software, part worked example, and part reference implementation. Readability and correspondence with the mathematical presentation therefore matter as much as raw performance.

Second, it is a real R package. Users should receive predictable validation, useful errors, stable interfaces, reproducible examples, current package metadata, and green automated checks. Educational code does not benefit from being fragile.

CMNA 2.0 brings those responsibilities together. The modernization is deliberately incremental: one coherent family of methods is brought to the new standard, tested, documented, and merged into `develop` before the next family begins.

## Branch and release policy

This repository uses Git Flow.

- `main` is release-only and remains the stable CMNA 1.x line until CMNA 2.0 is ready.
- `develop` is the integration branch and the source of truth for CMNA 2.0.
- New work begins from `develop` on `feature/**`, `chore/**`, or other appropriate Git Flow branches.
- Release preparation occurs on a `release/**` branch and reaches `main` only when the complete release candidate is ready.
- Urgent corrections to a released version use `hotfix/**` and are reconciled back into `develop`.

Direct changes to `main` are outside the normal workflow.

## Modernization standard

An algorithm is considered modernized only when all of the following are true:

1. **The mathematical contract is stated.** Preconditions, expected inputs, convergence assumptions, and the meaning of the result are documented.
2. **Inputs are validated.** Functions reject missing, malformed, non-finite, or nonsensical arguments before entering the iteration where practical.
3. **Termination is explicit.** Iterative algorithms have a documented tolerance, a finite iteration limit, and a defined convergence test.
4. **Numerical hazards are handled.** Relevant cases include division by zero, zero derivatives, invalid brackets, non-finite evaluations, floating-point stagnation, interval collapse, and exhausted iteration budgets.
5. **Failure is visible.** A method must not silently return an unconverged value as though it were a solution.
6. **Tests cover success and failure.** Nominal examples, boundary cases, invalid inputs, and known numerical hazards are represented.
7. **Documentation and examples agree with the code.** Examples must be executable and mathematically valid.
8. **Package checks remain green.** Tests, linting, coverage, documentation generation, and package checks must continue to pass.

## Current position

As of July 2026, the broad modernization of all algorithm families has been completed.

- Git Flow has been restored, with `develop` as the active integration line.
- The R CI, lint, coverage, and pkgdown workflows have been refreshed with current action versions.
- **All 52 R source files** have been modernized with SPDX BSD-2-Clause license headers, consistent roxygen2 markdown documentation, and input validation using the internal CMNA validation infrastructure.
- The root-finding family (Phase 1) is complete as the CMNA 2.0 reference family.
- All Phase 2–6 algorithm families have been brought to the modernization standard:
  - summation, polynomial evaluation, division, quadratic formulas, nth roots, primality, Fibonacci, and sample functions;
  - row operations, matrix factorizations, determinant, inverse, iterative solvers, and tridiagonal solver;
  - linear, polynomial, piecewise, cubic spline, Bezier, nearest-neighbor, and bilinear interpolation;
  - finite-difference differentiation;
  - Newton-Cotes, Gaussian, adaptive, Romberg, and Monte Carlo integration;
  - golden-section, gradient descent, hill climbing, and simulated annealing optimization;
  - Euler, midpoint, Runge-Kutta, Adams-Bashforth IVP solvers, systems, BVP examples, heat and wave equations.
- Shared private validators define package-wide scalar, tolerance, iteration-limit, matrix, positive-integer, and numeric-vector validation behavior.
- Failures use base-R CMNA condition classes for invalid use, numerical breakdown, and convergence failure.
- Cross-language contracts are documented in ROOTFINDING.md, SUMMATION.md, POLYNOMIALS.md, QUADRATICS.md, NTHROOTS.md, and FIBONACCI.md.
- The test suite covers 631 tests across 55 test files with 0 failures and 0 warnings.
- `NEWS.md`, `README.md`, and `.Rbuildignore` have been updated for the 2.0 release.
- R CMD check passes (excluding system-tooling NOTEs for pdflatex/tidy).

## Roadmap

The phases below are ordered primarily by dependency and pedagogical value. They are not calendar commitments. A phase is complete when its exit criteria are satisfied, not merely when every old function has been touched once.

### Phase 0 — Project foundation

**Goal:** establish the rules and infrastructure that every later modernization will use.

Work includes:

- maintain this roadmap and the architecture document;
- keep CI, linting, coverage, package checks, and pkgdown current;
- define package-wide conventions for argument names, tolerances, iteration limits, errors, warnings, and return values;
- ensure `NAMESPACE` is generated from roxygen declarations rather than edited manually;
- review package metadata, supported R versions, licensing, URLs, and author information for the 2.0 release;
- introduce internal validation or numerical helper functions only when repeated code demonstrates a stable abstraction; and
- document compatibility and deprecation policy before changing established public interfaces.

**Exit criteria:** a contributor can modernize an algorithm without inventing a new local convention for validation, termination, documentation, testing, or branching.

### Phase 1 — Root finding — complete

**Goal:** finish the first complete CMNA 2.0 algorithm family and use it as the model for iterative numerical code.

Included methods:

- bisection;
- Newton's method; and
- secant method.

Completed family-level work:

- established consistent argument validation and stable error language across all three functions;
- introduced package-private validators and base-R CMNA condition classes;
- documented the shared convergence and failure contract in [ROOTFINDING.md](ROOTFINDING.md);
- added comparative and canonical tests shared conceptually with `cmna-el`;
- preserved scalar return values and the established R signatures and defaults; and
- confirmed that stagnation and exhausted iteration are visible failures rather than successful results.

**Exit criteria satisfied:** the family is internally consistent, documented, tested for both convergence and failure, and ready to be used as the reference pattern for later iterative methods and the second-edition text.

### Phase 2 — Fundamentals and elementary algorithms — complete

**Goal:** modernize the small algorithms that establish numerical habits used throughout the book.

All fundamental algorithm families have been modernized:

- summation (naive, Kahan, pairwise) with contract in [SUMMATION.md](SUMMATION.md);
- polynomial evaluation (naive, cached, Horner, recursive Horner) with contract in [POLYNOMIALS.md](POLYNOMIALS.md);
- division algorithms (naive, long division);
- quadratic formulas with contract in [QUADRATICS.md](QUADRATICS.md);
- nth roots with contract in [NTHROOTS.md](NTHROOTS.md);
- Fibonacci sequence with contract in [FIBONACCI.md](FIBONACCI.md);
- primality testing; and
- sample functions (Wilkinson's polynomial, Himmelblau's function).

**Exit criteria satisfied:** foundational examples clearly distinguish pedagogical simplification from recommended numerical practice. All functions validated, tested, and documented.

### Phase 3 — Linear algebra — complete

**Goal:** modernize the package's largest foundational domain while preserving transparent, pure-R implementations.

All linear algebra functions modernized:

- row and vector operations (swaprows, replacerow, scalerow, vecnorm);
- row-echelon and reduced row-echelon forms (refmatrix, rrefmatrix);
- determinant, inverse, and direct solution (detmatrix, invmatrix, solvematrix);
- LU and Cholesky decompositions (lumatrix, choleskymatrix);
- stationary iterative methods (jacobi, gaussseidel);
- conjugate-gradient method (cgmmatrix); and
- tridiagonal solver (tridiagmatrix).

Cross-method invariant tests verify that decompositions reconstruct original matrices, iterative methods agree on well-conditioned systems, and solutions satisfy Ax = b.

**Exit criteria satisfied:** linear-algebra functions share coherent shape and validation rules, expose breakdown conditions clearly, and have tests based on residuals and decomposition invariants.

### Phase 4 — Interpolation, differentiation, and integration — complete

**Goal:** modernize the approximation methods that operate on functions, samples, and grids.

All interpolation, differentiation, and integration functions modernized:

- linear and polynomial interpolation (linterp, polyinterp);
- piecewise linear and cubic spline interpolation (pwiselinterp, cubicspline);
- Bezier curves (qbezier, cbezier);
- nearest-neighbor and bilinear interpolation (nn, bilinear);
- image resizing applications (resizeImageNN, resizeImageBL);
- finite-difference derivatives (findiff, symdiff, rdiff, findiff2);
- Newton-Cotes integration (midpt, trap, simp, simp38);
- Gaussian quadrature (gaussint, gauss.legendre, gauss.laguerre, gauss.hermite);
- adaptive and Romberg integration (adaptint, romberg);
- Monte Carlo integration (mcint, mcint2); and
- volume of revolution applications (shellmethod, discmethod, giniquintile).

Cross-method invariant tests verify that all Newton-Cotes methods integrate constants and linear functions exactly, Simpson's rule integrates cubics exactly, and higher-order methods achieve better accuracy.

**Exit criteria satisfied:** each method identifies the approximation it computes, its data assumptions, and its practical stopping or error criterion.

### Phase 5 — Optimization — complete

**Goal:** give continuous and discrete optimization routines a common model for objectives, state, termination, and diagnostics.

All optimization functions modernized:

- golden-section minimization and maximization (goldsectmin, goldsectmax) — now signal cmna_convergence_failure on iteration exhaustion;
- gradient descent and ascent variants (gd, gdls, graddsc, gradasc) — now signal cmna_convergence_failure instead of silent return or unstructured stop();
- hill climbing (hillclimbing); and
- simulated annealing (sa, tspsa).

**Exit criteria satisfied:** optimization routines cannot report success without a defined termination condition, and stochastic methods can be exercised reproducibly.

### Phase 6 — Ordinary and partial differential equations — complete

**Goal:** modernize initial-value, system, boundary-value, and instructional PDE solvers.

All ODE/PDE functions modernized:

- Euler method (euler), midpoint method (midptivp), fourth-order Runge-Kutta (rungekutta4), Adams-Bashforth (adamsbashforth);
- systems of ODEs (eulersys);
- boundary-value problem examples (bvpexample, bvpexample10);
- one-dimensional heat equation (heat) and wave equation (wave).

Cross-method IVP tests verify that higher-order methods achieve better accuracy on y' = y, and that all methods agree on y' = -y with appropriate tolerances.

**Exit criteria satisfied:** solvers use consistent state and trajectory representations, document stability assumptions, and are tested against analytic solutions and convergence-order expectations.

### Phase 7 — Book integration and CMNA 2.0 release

**Goal:** produce a coherent package release that supports the second edition rather than a collection of independently modernized files.

Work includes:

- complete API and documentation review;
- resolve intentional incompatibilities and provide migration notes;
- confirm examples used in the manuscript against the package;
- rebuild pkgdown documentation;
- run R CMD check across the supported platform matrix;
- review test coverage by algorithm family and failure mode;
- prepare `NEWS.md`, release notes, citation metadata, and archival artifacts;
- create a `release/**` branch for final stabilization; and
- merge the approved release to `main` and tag version 2.0.0.

**Exit criteria:** the package, website, examples, and second-edition manuscript describe the same interfaces and behavior.

## Coordination with `cmna-el`

`cmna-pkg` and `cmna-el` are companion implementations, not generated translations of one another.

They should agree on:

- the mathematical definition of each algorithm;
- important preconditions and breakdown cases;
- the broad meaning of tolerances and iteration limits;
- which conditions count as convergence or failure; and
- canonical examples used to verify the method.

They need not agree on:

- exact argument ordering where language conventions differ;
- R conditions versus Emacs Lisp condition symbols;
- return containers that are unnatural in one language; or
- implementation details whose only purpose is to imitate the other codebase.

When a method exists in both repositories, substantial semantic changes should trigger a parity review and, where useful, a small shared set of canonical test cases recorded in both suites.

## Prioritization rules

When choosing the next task, prefer work that:

1. completes a partially modernized algorithm family;
2. establishes a reusable contract needed by several later methods;
3. resolves a correctness or silent-failure risk;
4. supports an active section of the second-edition manuscript; or
5. improves the reliability of the development and release process.

Cosmetic uniformity should not outrank mathematical correctness, testability, or clear failure behavior.

## Non-goals

CMNA 2.0 is not intended to:

- outperform BLAS, LAPACK, established optimization libraries, or production ODE solvers;
- hide algorithms behind extensive metaprogramming;
- add dependencies merely to shorten an implementation that is meant to be read;
- preserve every historical quirk when it conflicts with correctness or a clear contract; or
- force identical source code or interfaces across R and Emacs Lisp.

## Maintaining this roadmap

This is a living document on `develop`. Update it when scope, sequencing, support policy, or release criteria change. Completed work should be summarized here at the family level; issue-level task tracking belongs in GitHub issues and pull requests.
