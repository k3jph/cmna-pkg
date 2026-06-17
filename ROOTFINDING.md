# Root-Finding Family Contract

This document records the shared mathematical contract for the scalar
root-finding methods implemented in `cmna-pkg` and `cmna-el`. The two packages
are companion implementations, not source translations. They agree on the
problem being solved, convergence meaning, important preconditions, and failure
categories while using interfaces and condition mechanisms natural to each
language.

## Included methods

- bisection;
- Newton's method; and
- the secant method.

In R these are exposed as `bisection()`, `newton()`, and `secant()`.

## Successful result

Each method returns a numeric scalar approximating a real root of a
caller-supplied function. No diagnostic wrapper is returned. Richer return
objects may be introduced only through a future package-wide decision.

An exact root at an initial endpoint or estimate is returned immediately. An
exact root encountered during iteration is also returned immediately.

## Convergence

- Bisection converges when the width of the bracketing interval is no greater
  than the requested tolerance. The returned value is the midpoint of the final
  interval.
- Newton and secant iteration converge when the absolute change between
  successive estimates is no greater than the requested tolerance.
- Every method has a finite maximum iteration count.
- A zero-sized update with a nonzero function value is floating-point
  stagnation, not convergence.

## Preconditions

Public functions require:

- function arguments where the method requires them;
- finite numeric scalar endpoints or initial estimates;
- a positive finite tolerance;
- a positive whole-number iteration limit;
- distinct secant estimates; and
- a valid sign-changing bracket for bisection unless an endpoint is already a
  root.

User-supplied functions and derivatives must continue to return finite numeric
scalars throughout iteration.

## Failure categories

All CMNA root-finding errors inherit from the base class `cmna_error` as well as
base R's `error` and `condition` classes.

### Invalid use

Malformed arguments and violated preconditions use `cmna_invalid_argument`.
An invalid bisection bracket additionally uses `cmna_invalid_bracket`.

### Numerical breakdown

A mathematically significant state prevents the next update:

- `cmna_non_finite_value` for a non-finite evaluation, denominator, or estimate;
- `cmna_zero_derivative` for a Newton update with zero derivative; and
- `cmna_zero_denominator` for an undefined secant update.

These also inherit from `cmna_numerical_breakdown`.

### Failed convergence

A valid iteration fails to satisfy its convergence rule:

- `cmna_stagnation` when floating-point arithmetic prevents progress; and
- `cmna_iteration_limit` when the iteration budget is exhausted.

These also inherit from `cmna_convergence_failure`.

Condition objects retain a stable message and, where practical, named context
such as the method, estimate, interval, iteration, and function value. The
implementation uses base R only; no condition-system dependency is required.

## Canonical cross-implementation cases

Both repositories intentionally test the following concepts:

1. all three methods approximate the positive root of `x^2 - 2` under an
   explicitly supplied common tolerance;
2. bisection accepts reversed endpoints and returns endpoint roots;
3. Newton returns an exact initial root and rejects a zero derivative;
4. secant returns either exact initial root and rejects a zero denominator;
5. all methods reject non-finite evaluations;
6. Newton and secant reject floating-point stagnation before accepting a
   zero-sized step as convergence; and
7. all methods visibly fail when their iteration budget is exhausted.

## Deliberate language-specific differences

- R retains its established arguments `f`, `fp`, `x`, `x0`, `x1`, `tol`, and
  `m`; Emacs Lisp uses its language-native names and optional positional
  controls.
- `cmna-pkg` uses base-R condition objects with CMNA-specific classes;
  `cmna-el` uses Emacs Lisp condition symbols and inheritance.
- The default controls differ intentionally for compatibility: the R functions
  retain the historical book-facing defaults `tol = 1e-3` and `m = 100`, while
  `cmna-el` uses package-wide defaults of `1e-9` and `1000`.
  Cross-implementation tests supply the same explicit tolerance rather than
  relying on defaults.

A substantial semantic change in either implementation should trigger review of
this document and the corresponding tests in both repositories.
