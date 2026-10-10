# intervals.idr

An exact rational interval library written in Idriç. The project is a concrete numerical and type-system convenience, comparable to units of measure; it is **not a foundation for incomplete knowledge**.

An interval represents a connected, convex subset of an ordered line, potentially empty or unbounded. It is useful even when all quantities are known exactly. By itself, an interval is not a probability distribution, confidence interval, credible interval, measurement claim, or general model of ignorance.

Broader uncertainty may involve indefinitely many interacting or nested ε-like regions, unknown resolution conditions, unknown containment depth, and strategically distorted information. No such general theory is claimed or forced into this library.

## Source

- `idric/Interval/Exact.idric`: exact rational endpoints; empty, open, closed and unbounded intervals; membership, addition, subtraction and intersection.
- `idric/Interval/Check.idric`: concrete propositions checked by Idriç.
- `intervals-idric.ipkg`: package for the pinned contemporary Idriç compiler.
- `docs/SEMANTICS.md`: mathematical meaning and limitations.
- `docs/IDRIC-PRIMARY.md`: language ownership and verification boundary.

The repository deliberately has no second implementation in generic Idris 2. Idriç is the maintained language and acceptance boundary. A host-level Idriç pass still does not establish direct Android, ARM, DEX, GPU, or other target-backend execution.

Concrete `Refl` fixtures establish particular reductions, not the general correctness theorems listed in [issue #1](https://github.com/dilapidated-shed/intervals.idr/issues/1) and the reference-code proof map.

See also [Idriç issue #30](https://github.com/isomorphisms/Idric/issues/30).
