# Fibonacci Numbers

Both CMNA implementations use zero-based indexing:

- `F(0) = 0`
- `F(1) = 1`
- `F(n) = F(n - 1) + F(n - 2)`

The R function is `fibonacci(n)`. The Emacs Lisp function is
`cmna-fibonacci`.

Both use iterative addition, requiring linear time and constant auxiliary
storage.

## Exactness

Emacs Lisp uses arbitrary-precision integers and returns exact values for
practical indices limited by available resources.

R stores these results as double-precision numeric values. Fibonacci numbers
through `F(78)` are exactly representable. `F(79)` is beyond the exact integer
range, so the R implementation accepts indices from 0 through 78 and rejects
larger indices instead of returning a rounded integer.

## Inputs

The index must be a nonnegative whole number. Negative, fractional,
non-numeric, and non-finite indices are rejected.

## Shared tests

Both repositories test `F(0)`, `F(1)`, `F(2)`, `F(10)`, and invalid indices.
R also tests `F(78)` and rejects `F(79)`. Emacs Lisp tests `F(100)` to confirm
exact bignum behavior.
