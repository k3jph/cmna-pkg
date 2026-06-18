# Real N-th Root Contract

This document records the shared conceptual contract for iterative real n-th
roots in `cmna-pkg` and `cmna-el`.

## Mathematical problem

For a finite scalar `a` and positive integer `n`, compute a real value `x` such
that

```text
x^n = a
```

Positive radicands are valid for every positive degree. Negative radicands are
valid only for odd degrees. Zero is returned exactly, and the first root of a
number is the number itself.

## Newton iteration

Both implementations solve the positive magnitude using

```text
x_next = ((n - 1) * x + abs(a) / x^(n - 1)) / n
```

and reapply a negative sign when the original radicand is negative and the
degree is odd.

## Successful result

The result is a real numeric scalar. Convergence is based on the residual

```text
abs(x^n - abs(a))
```

scaled by the magnitude of the radicand.

## Failure behavior

Both implementations reject:

- non-finite or non-numeric radicands;
- degrees that are not positive whole numbers;
- negative radicands with even degree;
- non-positive or non-finite tolerances; and
- invalid iteration limits.

The iteration reports non-finite intermediate values, zero denominators,
floating-point stagnation, and exhausted iteration limits rather than returning
an unconverged estimate.

## Canonical cross-implementation cases

Both repositories intentionally test:

1. `sqrt(100) = 10`;
2. the cube root of `1000` is `10`;
3. the fourth root of `65536` is `16`;
4. the seventh root of zero is exactly zero;
5. the cube root of `-125` is `-5`;
6. negative even roots are rejected; and
7. an intentionally tiny iteration budget produces an iteration-limit failure.

## Deliberate language-specific differences

- R preserves `nthroot(a, n, tol, m)` and its historical default tolerance.
- Emacs Lisp exposes `cmna-nth-root` and uses package-wide CMNA defaults when
  tolerance or maximum iterations are omitted.
- R reports base-R condition objects with CMNA classes.
- Emacs Lisp reports CMNA condition symbols.

A substantial semantic change in either implementation should trigger review of
this document and the corresponding tests in both repositories.
