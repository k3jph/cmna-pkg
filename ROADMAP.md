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

As of June 2026, the modernization has established the working pattern for CMNA 2.0.

- Git Flow has been restored, with `develop` as the active integration line.
- The R CI, lint, coverage, and pkgdown workflows have been refreshed.
- The root-finding family is complete as the first CMNA 2.0 reference family:
  - `bisection()` validates its bracket and termination conditions and handles endpoint roots, reversed bounds, non-finite evaluations, stagnation, and iteration exhaustion;
  - `newton()` validates the function and derivative throughout iteration and distinguishes zero derivatives, non-finite updates, stagnation, and failed convergence; and
  - `secant()` uses two explicit initial estimates and distinguishes zero and non-finite denominators, non-finite updates, stagnation, and failed convergence.
- Shared private validators now define package-wide scalar, tolerance, iteration-limit, checked-evaluation, and numeric-vector validation behavior.
- Root-finding failures use base-R CMNA condition classes for invalid use, numerical breakdown, and convergence failure.
- Canonical tests and [ROOTFINDING.md](ROOTFINDING.md) record the semantic contract shared with `cmna-el` and the differences intentionally retained by each language.
- Phase 2 has begun with the summation family:
  - `naivesum()` remains the readable left-to-right baseline;
  - `kahansum()` now implements the compensated Kahan update; and
  - `pwisesum()` remains the recursive pairwise summation example.
- [SUMMATION.md](SUMMATION.md) records the summation contract shared conceptually with `cmna-el`.

This is the beginning of CMNA 2.0, not the end. Much of the package still reflects the original implementation style and must be reviewed family by family.

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

### Phase 2 — Fundamentals and elementary algorithms — in progress

**Goal:** modernize the small algorithms that establish numerical habits used throughout the book.

The first completed slice is summation:

- naive summation as the readable baseline;
- Kahan summation as the compensated method; and
- pairwise summation as the recursive divide-and-combine method.

The summation contract is documented in [SUMMATION.md](SUMMATION.md), including the canonical low-order precision example shared conceptually with `cmna-el`.

Remaining likely scope includes:

- polynomial evaluation and expansion;
- division algorithms;
- quadratic formulas and nth roots;
- primality and sequence examples; and
- standard sample functions and polynomials.

Priority should be given to examples that teach floating-point error, stability, conditioning, or algorithmic complexity. Where two implementations intentionally demonstrate a naive and improved method, both should be preserved and the contrast tested and explained.

**Exit criteria:** foundational examples clearly distinguish pedagogical simplification from recommended numerical practice.

### Phase 3 — Linear algebra

**Goal:** modernize the package's largest foundational domain while preserving transparent, pure-R implementations.

Likely sequence:

1. row and vector operations;
2. norms and matrix validation;
3. row-echelon and reduced row-echelon forms;
4. determinant, inverse, and direct solution methods;
5. LU and Cholesky decompositions;
6. stationary iterative methods;
7. conjugate-gradient methods; and
8. tridiagonal and other structured solvers.

This phase requires explicit decisions about matrix shape, singularity, symmetry, definiteness, tolerances, pivoting, and return structures. Those decisions should be made at the family level rather than independently inside each function.

**Exit criteria:** linear-algebra functions share coherent shape and validation rules, expose breakdown conditions clearly, and have tests based on residuals and decomposition invariants rather than examples alone.

### Phase 4 — Interpolation, differentiation, and integration

**Goal:** modernize the approximation methods that operate on functions, samples, and grids.

Scope includes:

- linear and polynomial interpolation;
- piecewise and cubic splines;
- Bezier methods;
- nearest-neighbor and bilinear interpolation;
- finite-difference derivatives;
- Newton-Cotes formulas;
- Gaussian quadrature;
- adaptive integration;
- Romberg integration;
- Monte Carlo integration; and
- instructional applications such as image resizing and solids of revolution.

Cross-cutting concerns include ordering of sample points, duplicate abscissas, grid dimensions, vectorization expectations, interval orientation, recursive depth, stochastic reproducibility, and error estimates.

**Exit criteria:** each method identifies the approximation it computes, its data assumptions, and its practical stopping or error criterion.

### Phase 5 — Optimization

**Goal:** give continuous and discrete optimization routines a common model for objectives, state, termination, and diagnostics.

Scope includes:

- golden-section minimization and maximization;
- gradient ascent and descent variants;
- line-search variants;
- hill climbing;
- simulated annealing; and
- the traveling-salesperson example.

This phase should distinguish deterministic numerical methods from stochastic search. Randomized algorithms must support reproducible tests and clearly document whether state or traces are returned.

**Exit criteria:** optimization routines cannot report success without a defined termination condition, and stochastic methods can be exercised reproducibly.

### Phase 6 — Ordinary and partial differential equations

**Goal:** modernize initial-value, system, boundary-value, and instructional PDE solvers.

Likely sequence:

- Euler and midpoint methods;
- fourth-order Runge-Kutta;
- multistep methods;
- systems of ODEs;
- boundary-value examples;
- one-dimensional heat and wave equations.

Key architectural decisions include the representation of state vectors, time grids, step sizes, returned trajectories, boundary conditions, and stability restrictions.

**Exit criteria:** solvers use consistent state and trajectory representations, document stability assumptions, and are tested against analytic solutions or convergence-order expectations where available.

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
