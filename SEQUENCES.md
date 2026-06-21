# Deterministic Numeric Sequence Contract

This document records the shared conceptual contract for numeric sequences in
`cmna-pkg` and `cmna-el`.

## Included methods

- R exposes `cmna_sequence(from, to, by)`.
- Emacs Lisp exposes `cmna-sequence`.

Both methods construct a finite sequence by repeated addition.

## Input contract

`from`, `to`, and `by` must be finite numeric scalars.

`by` must be nonzero and must point from `from` toward `to`:

- ascending intervals require a positive increment;
- descending intervals require a negative increment; and
- equal endpoints accept either sign, provided the increment is nonzero.

## Endpoint behavior

The first value is always `from`.

The endpoint is included when it is reached, allowing for ordinary
floating-point roundoff. When repeated addition would cross the endpoint, the
sequence stops at the previous value.

Examples:

```text
1 to 5 by 1     -> 1, 2, 3, 4, 5
5 to 1 by -1    -> 5, 4, 3, 2, 1
0 to 5 by 3     -> 0, 3
2 to 2 by -1    -> 2
```

For floating-point increments, a value within a small machine-roundoff window
of the endpoint is replaced by the exact endpoint. Thus `0` to `1` by `0.1`
ends with exactly `1`.

## Failure behavior

Both implementations reject:

- zero increments;
- increments pointing away from the endpoint;
- non-numeric inputs; and
- non-finite inputs.

## Deliberate language-specific differences

- R returns a numeric vector and reports CMNA-classed R conditions.
- Emacs Lisp returns a list and reports Emacs Lisp condition symbols.
- The public names remain idiomatic to their host languages.

A substantial semantic change in either implementation should trigger review of
this document and the corresponding tests in both repositories.
