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

### Behavioral Changes

The only behavioral difference is that functions now throw structured errors
(`cmna_invalid_argument` condition) for invalid inputs that previously would have
produced cryptic R errors or silently wrong results. Examples:

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

### Recommendation

This modernization is fully backward-compatible for all valid usage. The only
breaking change is the removal of the accidentally-exported internal helper
`.cmna_validate_quadratic_coefficients`, which no external code should reference.
