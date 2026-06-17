# Summation Family Contract

This document records the shared mathematical contract for the summation methods
implemented in `cmna-pkg` and `cmna-el`. The two packages are companion
implementations, not source translations. They agree on the numerical ideas and
canonical cases while retaining language-native names, data structures, and
condition mechanisms.

## Included methods

In R, the summation family includes:

- `naivesum()` — left-to-right summation;
- `kahansum()` — Kahan compensated summation; and
- `pwisesum()` — recursive pairwise summation.

## Successful result

Each method returns a numeric scalar sum.

The empty vector and `NULL` return zero. A single-element vector returns that
single value as a scalar.

## Input contract

The R implementation accepts numeric vectors and `NULL`. Non-numeric inputs are
invalid use and signal a base-R condition inheriting from `cmna_invalid_argument`
and `cmna_error`.

Non-finite numeric values are permitted. They follow base-R arithmetic:

- `NA` propagates as missing;
- `NaN` propagates as not-a-number;
- `Inf` and `-Inf` follow ordinary floating-point addition.

## Algorithmic distinction

`naivesum()` is intentionally direct: it adds values from left to right and is
therefore sensitive to the order and scale of partial sums.

`kahansum()` maintains a compensation term. The compensation tracks low-order
information lost during the previous addition and reinserts it into subsequent
steps.

`pwisesum()` recursively divides the vector, sums the halves, and combines the
partial results. It is deterministic for a fixed input order but does not share
Kahan's compensation state.

## Canonical cross-implementation cases

Both repositories intentionally test the following concepts:

1. ordinary numeric vectors produce the expected scalar sum;
2. empty input returns zero;
3. single-element input returns that element;
4. non-numeric input is rejected;
5. non-finite numeric values propagate according to the host language's ordinary
   arithmetic; and
6. a small-correction example demonstrates that compensated summation can retain
   low-order information lost by naive left-to-right summation.

The canonical compensated-summation example is:

```text
1, followed by one thousand copies of 1e-16, followed by -1
```

The exact mathematical sum is `1e-13`. Left-to-right summation loses the small
increments after the leading `1`; Kahan summation recovers them to useful
accuracy.

## Deliberate language-specific differences

- R preserves the historical public names `naivesum()`, `kahansum()`, and
  `pwisesum()`.
- Emacs Lisp uses the `cmna-` namespace and exposes `cmna-sum`,
  `cmna-naive-sum`, and `cmna-kahan-sum`.
- R accepts numeric vectors and `NULL`; Emacs Lisp accepts proper lists of
  numbers.
- R permits non-finite values and follows base-R arithmetic. Emacs Lisp permits
  numeric values and follows Emacs Lisp arithmetic.
- Neither implementation returns diagnostic wrappers.

A substantial semantic change in either implementation should trigger review of
this document and the corresponding tests in both repositories.
