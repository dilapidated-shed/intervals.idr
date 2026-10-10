# intervals.idr

An exact rational interval library intended for Idriç. The project is a concrete numerical and type-system convenience, comparable to units of measure; it is **not a foundation for incomplete knowledge**.

An interval represents a connected, convex subset of an ordered line, potentially empty or unbounded. It is useful even when all quantities are known exactly. By itself, an interval is not a probability distribution, confidence interval, credible interval, measurement claim, or general model of ignorance.

Broader uncertainty may involve indefinitely many interacting or nested ε-like regions, unknown resolution conditions, unknown containment depth, and strategically distorted information. No such general theory is claimed or forced into this library.

## Maintained Idriç source

- `idric/Interval/Exact.idric`: canonical Idriç interval library.
- `idric/Interval/Check.idric`: concrete propositions checked by Idriç.
- `intervals-idric.ipkg`: current-language package.
- `docs/IDRIC-PRIMARY.md`: language ownership and verification boundary.

## Idris 2 compatibility prototype

- `src/Interval/Exact.idr`: exact rationals with structurally positive denominator; finite/unbounded endpoints, open/closed membership, emptiness, Minkowski addition, interval subtraction, and intersection.
- `src/Interval/Tests.idr`: compile-time equality witnesses for endpoint behavior, arithmetic, unboundedness, and the dependency loss in `x - x`.
- `docs/SEMANTICS.md`: mathematical assumptions and known limitations.
- `docs/IDRIC.md`: intended bridge to the current Idriç language.

The `.idr` files under `src/` are legacy compatibility tests, not the maintained API. A passing generic Idris 2 build is not evidence that the Idriç source compiled or that a direct target backend ran.

## Legacy compatibility check

With Idris 2 and its standard library installed:

```sh
idris2 --build intervals.ipkg
./build/exec/interval-tests
```

Compilation checks the concrete `Refl` fixtures; it does not establish the general correctness theorems still listed in issue #1 and the reference-code proof map. Backend execution must also succeed to claim the runnable test program works.

See [design issue #1](https://github.com/dilapidated-shed/intervals.idr/issues/1) and [Idriç issue #30](https://github.com/isomorphisms/Idric/issues/30).
