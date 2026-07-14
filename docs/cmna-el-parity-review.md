# CMNA Emacs Lisp Parity Review

Comparison of the R package (`cmna-pkg`) against the Emacs Lisp port (`cmna-el`).

Generated: 2026-07-14

## Summary

- **R exported functions**: 81
- **EL public functions**: 9 (plus 5 utility macros/helpers)
- **Coverage**: ~11% of R API surface

---

## 1. Function-by-Function Mapping

### Implemented in EL

| R Function | R Signature | EL Function | EL Signature | Notes |
|---|---|---|---|---|
| `bisection(f, a, b, tol=1e-3, m=100)` | bisection.R | `bisection-method(func a b &optional tolerance max-iterations)` | cmna-rootfinding.el | Default differences (see below) |
| `newton(f, fp, x, tol=1e-3, m=100)` | newton.R | `newton-method(func func-prime guess &optional tolerance max-iterations)` | cmna-rootfinding.el | Default differences (see below) |
| `secant(f, x0, x1, tol=1e-3, m=100)` | secant.R | `secant-method(func guess-1 guess-2 &optional tolerance max-iterations)` | cmna-rootfinding.el | Default differences (see below) |
| `midpt(f, a, b, m=100)` | midpt.R | `midpoint-rule(func a b n)` | cmna-integration.el | `n` is required in EL (no default) |
| `trap(f, a, b, m=100)` | trap.R | `trapezoid-rule(func a b n)` | cmna-integration.el | `n` is required in EL (no default) |
| `simp(f, a, b, m=100)` | simp.R | `simpsons-rule(func a b n)` | cmna-integration.el | `n` is required in EL (no default) |
| `wilkinson(x, w=20)` | wilkinson.R | `wilkinson-polynomial(x &optional degree)` | cmna-miscellaneous.el | Matches; default degree=20 |
| `naivesum(x)` | naivesum.R | `sum(x)` | cmna-fundamentals.el | EL name differs; algorithm similar (simple accumulation) |
| (none) | -- | `arithmetic-mean(x)` | cmna-fundamentals.el | No direct R counterpart in CMNA |

### EL Utility Functions (no direct R counterpart)

| EL Function/Macro | File | Purpose |
|---|---|---|
| `float-equal?(x y &optional tolerance)` | cmna-utilities.el | Floating-point approximate equality |
| `sequence(from to by)` | cmna-utilities.el | Number sequence generator (R has `seq()` built-in) |
| `positivep(x)` | cmna-utilities.el | Macro: test x > 0 |
| `positive-or-zerop(x)` | cmna-utilities.el | Macro: test x >= 0 |
| `negativep(x)` | cmna-utilities.el | Macro: test x < 0 |
| `negative-or-zerop(x)` | cmna-utilities.el | Macro: test x <= 0 |

### EL Infrastructure (no R counterpart)

| File | Purpose |
|---|---|
| `cmna-defaults.el` | Default tolerance (1e-9) and max iterations (1e3) |
| `cmna-errors.el` | Custom error type hierarchy |
| `cmna.el` | Package entry point / requires |

---

## 2. Default Parameter Value Differences

| Function | Parameter | R Default | EL Default | Impact |
|---|---|---|---|---|
| bisection / bisection-method | tolerance | `1e-3` | `1e-9` (via `cmna-default-tolerance`) | EL converges to much tighter tolerance |
| bisection / bisection-method | max iterations | `100` | `1000` (via `cmna-default-maximum-iterations`) | EL allows 10x more iterations |
| newton / newton-method | tolerance | `1e-3` | `1e-9` | Same as above |
| newton / newton-method | max iterations | `100` | `1000` | Same as above |
| secant / secant-method | tolerance | `1e-3` | `1e-9` | Same as above |
| secant / secant-method | max iterations | `100` | `1000` | Same as above |
| midpt / midpoint-rule | m / n | `100` (optional) | Required (no default) | EL requires caller to specify |
| trap / trapezoid-rule | m / n | `100` (optional) | Required (no default) | EL requires caller to specify |
| simp / simpsons-rule | m / n | `100` (optional) | Required (no default) | EL requires caller to specify |

---

## 3. Parameter Naming Differences

| R Name | EL Name | Context |
|---|---|---|
| `f` | `func` | Function argument in all methods |
| `fp` | `func-prime` | Derivative in Newton's method |
| `x` (newton) | `guess` | Initial guess |
| `x0`, `x1` (secant) | `guess-1`, `guess-2` | Initial guesses |
| `tol` | `tolerance` | Convergence tolerance |
| `m` | `max-iterations` or `n` | Iteration/interval count |
| `w` (wilkinson) | `degree` | Polynomial degree |
| `m` (integration) | `n` | Number of subintervals |

---

## 4. Algorithmic Differences

### bisection / bisection-method
- **R**: Uses `while` loop; checks `abs(b - a) > tol`; returns midpoint.
- **EL**: Uses `named-let` recursion; uses `float-equal?` for convergence; sorts `a`/`b` into `lower-bound`/`upper-bound` at start.
- **Difference**: R checks `abs(b - a) > tol`; EL checks `float-equal?(lower-bound upper-bound tolerance)` which tests `abs(x - y) <= tolerance`. Logically equivalent but EL also short-circuits on `inner-point = 0.0` (exact root).

### newton / newton-method
- **R**: Uses `while` loop; converges when `abs(x1 - x0) < tol`.
- **EL**: Uses `named-let` recursion; converges when `float-equal?(guess next-guess tolerance)`.
- **Difference**: Equivalent logic.

### secant / secant-method
- **R**: Uses `while` loop; standard secant formula.
- **EL**: Uses `named-let` recursion; same secant formula.
- **Difference**: EL adds explicit check that `guess-1 != guess-2` at start. Otherwise equivalent.

### midpt / midpoint-rule
- **R**: Standard midpoint quadrature with `for` loop.
- **EL**: Uses `named-let` recursion; same formula.
- **Difference**: Equivalent.

### trap / trapezoid-rule
- **R**: Standard trapezoidal rule with `for` loop.
- **EL**: Uses `named-let` recursion; slightly different bookkeeping (carries forward `val-lower-bound` to avoid redundant function evaluations).
- **Difference**: EL is slightly more efficient (avoids re-evaluating `f` at shared points). Results equivalent.

### simp / simpsons-rule
- **R**: Standard composite Simpson's rule.
- **EL**: Uses `named-let` recursion with midpoint evaluation.
- **Difference**: The EL implementation uses Simpson's 1/3 rule with a different decomposition style (evaluating at midpoints of each subinterval). The final scaling factor is `h/6` in EL vs `h/3` in R, reflecting different formulations. Both should produce equivalent results for the same `n`.

### wilkinson / wilkinson-polynomial
- **R**: `prod(x - 1:w)` using vectorized arithmetic.
- **EL**: Uses `named-let` recursion computing `product(x - k)` for k from degree down to 1.
- **Difference**: Equivalent.

### naivesum / sum
- **R**: `naivesum` uses a `for` loop accumulator.
- **EL**: `sum` uses `named-let` tail recursion.
- **Difference**: Equivalent algorithm. Note: R also exports `kahansum` and `pwisesum` which have no EL counterparts.

---

## 5. Functions Present in R but Missing from EL (72 functions)

### Integration (5 missing)
| R Function | Description |
|---|---|
| `adaptint` | Adaptive integration |
| `gaussint` | Gaussian quadrature (generic) |
| `gauss.legendre` | Gauss-Legendre quadrature |
| `gauss.laguerre` | Gauss-Laguerre quadrature |
| `gauss.hermite` | Gauss-Hermite quadrature |
| `mcint` | Monte Carlo integration (1D) |
| `mcint2` | Monte Carlo integration (2D) |
| `romberg` | Romberg integration |
| `simp38` | Simpson's 3/8 rule |

### Root Finding (0 missing)
All three R root-finding methods (bisection, newton, secant) are implemented.

### Interpolation (6 missing)
| R Function | Description |
|---|---|
| `linterp` | Linear interpolation |
| `polyinterp` | Polynomial interpolation |
| `pwiselinterp` | Piecewise linear interpolation |
| `cubicspline` | Cubic spline interpolation |
| `bilinear` | Bilinear interpolation |
| `nn` | Nearest neighbor interpolation |

### Curve Fitting / Bezier (2 missing)
| R Function | Description |
|---|---|
| `qbezier` | Quadratic Bezier curve |
| `cbezier` | Cubic Bezier curve |

### Finite Differences (4 missing)
| R Function | Description |
|---|---|
| `findiff` | Forward finite difference |
| `symdiff` | Symmetric finite difference |
| `findiff2` | Second-order finite difference |
| `rdiff` | Richardson extrapolation |

### Polynomial Evaluation (4 missing)
| R Function | Description |
|---|---|
| `horner` | Horner's method |
| `rhorner` | Recursive Horner's method |
| `naivepoly` | Naive polynomial evaluation |
| `betterpoly` | Improved polynomial evaluation |

### Summation (2 missing)
| R Function | Description |
|---|---|
| `kahansum` | Kahan compensated summation |
| `pwisesum` | Pairwise summation |

### Division (2 missing)
| R Function | Description |
|---|---|
| `naivediv` | Naive long division |
| `longdiv` | Long division |

### Linear Algebra - Direct Methods (10 missing)
| R Function | Description |
|---|---|
| `choleskymatrix` | Cholesky decomposition |
| `detmatrix` | Matrix determinant |
| `invmatrix` | Matrix inverse |
| `lumatrix` | LU decomposition |
| `refmatrix` | Row echelon form |
| `rrefmatrix` | Reduced row echelon form |
| `solvematrix` | Solve linear system via RREF |
| `swaprows` | Row swap operation |
| `replacerow` | Row replacement operation |
| `scalerow` | Row scaling operation |

### Linear Algebra - Iterative Methods (4 missing)
| R Function | Description |
|---|---|
| `jacobi` | Jacobi iterative method |
| `gaussseidel` | Gauss-Seidel iterative method |
| `cgmmatrix` | Conjugate gradient method |
| `gdls` | Gradient descent least squares |
| `tridiagmatrix` | Tridiagonal matrix solver |
| `vecnorm` | Vector norm |

### Initial Value Problems (4 missing)
| R Function | Description |
|---|---|
| `euler` | Euler's method |
| `midptivp` | Midpoint method for IVPs |
| `rungekutta4` | 4th-order Runge-Kutta |
| `adamsbashforth` | Adams-Bashforth method |

### IVP Systems (1 missing)
| R Function | Description |
|---|---|
| `eulersys` | Euler's method for systems |

### Boundary Value Problems (2 missing)
| R Function | Description |
|---|---|
| `bvpexample` | BVP example function |
| `bvpexample10` | BVP example (10 steps) |

### PDEs (2 missing)
| R Function | Description |
|---|---|
| `heat` | Heat equation solver |
| `wave` | Wave equation solver |

### Optimization (7 missing)
| R Function | Description |
|---|---|
| `goldsectmin` | Golden section minimum |
| `goldsectmax` | Golden section maximum |
| `graddsc` | Gradient descent |
| `gradasc` | Gradient ascent |
| `gd` | Generic gradient descent |
| `hillclimbing` | Hill climbing |
| `sa` | Simulated annealing |
| `tspsa` | TSP via simulated annealing |

### Quadratic Formula (2 missing)
| R Function | Description |
|---|---|
| `quadratic` | Quadratic formula |
| `quadratic2` | Alternative quadratic formula |

### Miscellaneous (5 missing)
| R Function | Description |
|---|---|
| `fibonacci` | Fibonacci numbers |
| `isPrime` | Primality test |
| `himmelblau` | Himmelblau's function |
| `giniquintile` | Gini coefficient from quintiles |
| `nthroot` | Nth root via Newton's method |

### Image Processing (2 missing)
| R Function | Description |
|---|---|
| `resizeImageNN` | Nearest-neighbor image resize |
| `resizeImageBL` | Bilinear image resize |

### Solids of Revolution (2 missing)
| R Function | Description |
|---|---|
| `shellmethod` | Shell method integration |
| `discmethod` | Disc method integration |

---

## 6. Functions in EL with No R Counterpart

| EL Function | File | Notes |
|---|---|---|
| `arithmetic-mean` | cmna-fundamentals.el | Not exported from R package |
| `float-equal?` | cmna-utilities.el | R uses `abs(x-y) < tol` inline |
| `sequence` | cmna-utilities.el | R has built-in `seq()` |
| `positivep` | cmna-utilities.el | R has no direct equivalent macro |
| `positive-or-zerop` | cmna-utilities.el | R has no direct equivalent macro |
| `negativep` | cmna-utilities.el | R has no direct equivalent macro |
| `negative-or-zerop` | cmna-utilities.el | R has no direct equivalent macro |

---

## 7. Structural Differences

| Aspect | R Package | EL Package |
|---|---|---|
| Error handling | Custom condition classes via `.cmna_abort()` | Custom error types via `define-error` |
| Input validation | Dedicated `.cmna_validate_*` internal functions | Inline checks with `unless`/`when` + `signal` |
| Iteration style | `for`/`while` loops | `named-let` tail recursion |
| Global defaults | Hardcoded per-function | Centralized in `cmna-defaults.el` |
| Dependencies | `stats::rnorm`, `stats::runif`, `utils::tail` | `stops` package |
| Naming convention | Short names (`bisection`, `trap`, `simp`) | Descriptive names (`bisection-method`, `trapezoid-rule`, `simpsons-rule`) |
