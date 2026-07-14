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

* Test suite expanded from ~20 legacy tests to 500+ tests covering all
  exported functions, using testthat edition 3. Includes edge cases,
  validation error paths, numerical contracts, and cross-method
  invariants.

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
