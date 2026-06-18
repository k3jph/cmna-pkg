# Real Quadratic Root Contract

This document records the shared conceptual contract for solving

```text
a*x^2 + b*x + c = 0
```

in `cmna-pkg` and `cmna-el`.

## Scope

Both implementations solve for **real roots only**.

The leading coefficient must be finite and nonzero. The remaining coefficients
must also be finite numeric scalars. A negative discriminant is outside the
real-root contract and signals a domain error rather than returning complex
values.

## Included methods

The R package exposes:

- `quadratic()` — the textbook quadratic formula; and
- `quadratic2()` — a cancellation-resistant formulation.

The Emacs Lisp package exposes:

- `cmna-quadratic-roots`; and
- `cmna-quadratic-roots-stable`.

## Successful result

Each method returns exactly two real roots in ascending numeric order.

A repeated root appears twice. For example,

```text
4*x^2 - 4*x + 1 = 0
```

returns `(0.5, 0.5)`.

## Numerical distinction

The textbook formula computes both roots directly as

```text
(-b ± sqrt(b^2 - 4*a*c)) / (2*a)
```

and can lose precision when subtraction combines nearly equal quantities.

The stable formulation first computes

```text
q = -0.5 * (b + sign(b) * sqrt(discriminant))
```

with `sign(0)` treated as positive. It then computes one root as `q/a` and the
other from the product-of-roots identity `c/q` when possible.

## Canonical cross-implementation cases

Both repositories intentionally test:

1. distinct roots for `x^2 - 1 = 0`;
2. a repeated root for `4*x^2 - 4*x + 1 = 0`;
3. a zero constant term for `x^2 - 3*x = 0`;
4. a cancellation-sensitive case, `x^2 - 1e8*x + 1 = 0`;
5. rejection of a zero leading coefficient;
6. rejection of invalid coefficients; and
7. rejection of negative discriminants.

## Deliberate language-specific differences

- R uses base-R condition objects with CMNA-specific classes.
- Emacs Lisp uses condition symbols such as `wrong-type-argument` and
  `cmna-domain-error`.
- R returns a numeric vector; Emacs Lisp returns a two-element list.
- Public names remain language-native and need not match exactly.

A substantial semantic change in either implementation should trigger review of
this document and the corresponding tests in both repositories.
