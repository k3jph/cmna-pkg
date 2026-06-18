# Polynomial Evaluation Contract

This document records the shared conceptual contract for polynomial evaluation
in `cmna-pkg` and `cmna-el`.

## Coefficient order

Both implementations use coefficients in ascending power order:

```text
(a0, a1, a2, ..., an)
```

represents

```text
a0 + a1*x + a2*x^2 + ... + an*x^n
```

For example, `(5, -3, 2)` represents `5 - 3*x + 2*x^2`.

This convention is retained because it is the established public R interface.

## Included methods

The R package exposes:

- `naivepoly()` — computes each power independently;
- `betterpoly()` — reuses a cached power of `x`;
- `horner()` — iterative Horner evaluation; and
- `rhorner()` — recursive Horner evaluation.

The Emacs Lisp package exposes:

- `cmna-polynomial-evaluate-naive`; and
- `cmna-polynomial-evaluate-horner`.

## Successful result

R accepts scalar or vector `x` and returns a numeric vector of matching length.
Emacs Lisp accepts a scalar `x` and returns a scalar value.

A one-element coefficient collection represents a constant polynomial.
Coefficient collections must be non-empty.

## Input behavior

Coefficients and evaluation points must be numeric. Non-finite numeric values
follow ordinary host-language arithmetic.

## Canonical cross-implementation cases

Both repositories intentionally test:

1. the polynomial `5 - 3*x + 2*x^2` at `x = -2, -1, 0, 1, 2`;
2. constant polynomials;
3. empty coefficient rejection;
4. non-numeric input rejection; and
5. equality between direct and Horner evaluation.

## Algorithmic distinction

Naive evaluation mirrors the written polynomial directly but recomputes powers.
Cached-power evaluation reduces repeated exponentiation. Horner evaluation
rewrites the polynomial as nested multiplication and addition, requiring one
multiply and one addition per coefficient after initialization.

The two repositories need not expose identical sets of helper variants, but they
must preserve the same coefficient interpretation and canonical results.
