# CMNA Package — Public API Compatibility Review

## Branch: feature/r-package-modernization vs develop

### Export Mechanism Change

- **develop:** Empty NAMESPACE (no explicit exports; `exportPattern` in roxygen
  comments caused all `@export`-tagged functions to be listed)
- **modernized:** Explicit `export()` directives for all 81 public functions plus
  `importFrom` for `stats::rnorm`, `stats::runif`, `utils::tail`

### Export Diff

| Change | Function | Justification |
|---|---|---|
| Removed | `.cmna_validate_quadratic_coefficients` | Internal helper (dot-prefixed); should never have been exported. No user code should depend on it. |

All 81 public functions from develop are present and exported in the modernized branch.

### Signature Changes

**None.** Every public function retains its original parameter names, order, and
default values. The modernization added input validation calls inside function
bodies but did not change any signatures.

### Return Value Changes

**None.** All functions return the same types and structures as before. No return
values were altered.

### Bug Fixes (changed valid-input behavior)

| Function | Previous behavior | Fixed behavior |
|---|---|---|
| `refmatrix()` / `rrefmatrix()` | Crash (NaN → "missing value") on all-zero columns | Correctly advances pivot column |
| `nthroot()` | Fails for very large/small radicands | Exponent-based initial guess + relative convergence |
| Integration routines | Silent wrong results for scalar integrands | `.cmna_eval_vectorized()` broadcasts and validates |

### Breaking Changes

| Function | Previous | Current | Impact |
|---|---|---|---|
| `goldsectmin()` / `goldsectmax()` | `warning()` + return partial result | `cmna_convergence_failure` error | **Breaking**: callers catching warnings lose the partial result. Mitigate with `tryCatch(..., cmna_convergence_failure = ...)`. |
| `graddsc()` / `gradasc()` / `gd()` | `stop("No solution found")` | `cmna_convergence_failure` structured error | Soft: same control flow, now catchable by class |
| `bisection()` / `newton()` / `secant()` / `nthroot()` | Silent loop exit or R arithmetic error | `cmna_convergence_failure` structured error | New error path for previously undefined behavior |

### Other Behavioral Changes

Functions now throw structured errors (`cmna_invalid_argument` condition) for
invalid inputs that previously would have produced cryptic R errors or silently
wrong results. Examples:

- Passing a string where a numeric is expected now gives:
  `"x must be a finite numeric scalar"` (class `cmna_invalid_argument`)
- Passing a non-square matrix to `choleskymatrix()` now gives:
  `"m must be a square matrix"` (class `cmna_invalid_argument`)

These are additive — they only trigger on inputs that would have failed anyway.
Valid inputs produce identical results.

### Condition Hierarchy

New condition classes (all internal, but catchable by users):

```
cmna_error
├── cmna_invalid_argument     (bad input type/value)
├── cmna_numerical_breakdown  (NaN/Inf during computation)
└── cmna_convergence_failure  (iteration limit reached)
```

All conditions inherit from `error` and `condition` per R conventions.

### New Dependencies

- No new package dependencies added
- `importFrom(stats, rnorm)`, `importFrom(stats, runif)`, `importFrom(utils, tail)`
  were already implicitly used; now declared explicitly

### DESCRIPTION Changes

- Version: unchanged (1.99.0)
- License: unchanged (BSD-2-Clause)
- Added: `Config/testthat/edition: 3`
- Updated: `RoxygenNote` to current version

### Condition Subclass Addition

```
cmna_error
├── cmna_invalid_argument
├── cmna_numerical_breakdown
├── cmna_convergence_failure
│   └── cmna_iteration_limit
└── cmna_domain_error
```

### Recommendation

The modernization is backward-compatible for all valid usage with one genuine
breaking change: `goldsectmin()`/`goldsectmax()` now error instead of warning on
iteration exhaustion. Callers that relied on catching the warning and using the
partial result must switch to `tryCatch()` with `cmna_convergence_failure`.
The removal of the accidentally-exported internal `.cmna_validate_quadratic_coefficients`
is not expected to affect any user code.
