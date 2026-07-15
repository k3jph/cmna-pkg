# cmna 1.99.0

## Breaking changes

* All functions now validate their inputs and signal structured CMNA
  condition objects (`cmna_error`, `cmna_invalid_argument`,
  `cmna_convergence_failure`, `cmna_numerical_breakdown`) instead of
  producing cryptic downstream errors or silently returning wrong
  results.

* `goldsectmin()` / `goldsectmax()` now signal `cmna_convergence_failure`
  instead of issuing a warning when the iteration limit is reached.

* `gd()` and `graddsc()` / `gradasc()` now signal `cmna_convergence_failure`
  instead of silently returning or calling `stop()` with an unstructured
  message.

## Bug fixes

* `refmatrix()` / `rrefmatrix()` no longer crash on matrices with
  all-zero columns. The pivot-search loop could exit with a zero pivot,
  causing division by zero and a "missing value where TRUE/FALSE needed"
  error.
* `nthroot()` now handles extreme radicands correctly. The initial guess
  uses an exponent-based estimate `2^(floor(log2(a)) %/% n)` instead of
  `a/n`, and convergence uses a relative criterion instead of absolute.
  Previously, very large values exhausted iterations and very small
  values converged prematurely.
* Integration routines (`trap`, `simp`, `simp38`, `midpt`, `gaussint`,
  `mcint`, `mcint2`) now handle scalar-returning integrands correctly
  via `.cmna_eval_vectorized()`. Previously, `function(x) 5` silently
  produced wrong results or NA.
* `isPrime(1)` now correctly returns `FALSE` (previously could error).
* `wave()` documentation previously said "heat equation" (copy-paste
  error); corrected to "wave equation".
* `gdls()` documentation fixed "graident" typo.
* `wilkinson()` documentation fixed "polynomail" typo.
* `invmatrix()` example now actually demonstrates `invmatrix()` instead
  of `refmatrix()`.

## Improvements

* All 52 R source files modernized with SPDX BSD-2-Clause license
  headers, consistent roxygen2 markdown documentation, and input
  validation using the internal CMNA validation infrastructure.

* New internal validators: `.cmna_validate_pos_integer()`,
  `.cmna_validate_nonneg_integer()`, `.cmna_validate_square_matrix()`,
  `.cmna_validate_matrix()`, `.cmna_validate_positive_scalar()`.

* Test suite expanded from ~20 legacy tests to 1040+ tests covering all
  81 exported functions, using testthat edition 3. Includes edge cases,
  validation error paths, numerical contracts, cross-method invariants,
  independent mathematical oracle tests, deep correctness tests
  for floating-point robustness, failure semantic tests, and callback
  safety tests.

* All existing tests migrated to testthat edition 3 (positional
  tolerance arguments replaced with named `tolerance =`, deprecated
  `context()` calls removed).

* `DESCRIPTION` updated: version 1.99.0, removed unnecessary Suggests,
  added GitHub URL, improved package description text, declared
  testthat edition 3.

* `README.md` updated: fixed stale URLs (codecov, testthat, roxygen2),
  corrected typos in algorithm list, improved formatting consistency.

* `.Rbuildignore` updated to exclude contract documents and build
  artifacts from the package tarball.
