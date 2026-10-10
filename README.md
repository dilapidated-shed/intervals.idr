# intervals.idr

An exact rational interval library written in Idriç. The project is a concrete numerical and type-system convenience, comparable to units of measure; it is **not a foundation for incomplete knowledge**.

An interval represents a connected, convex region of an ordered exact-rational line, potentially empty or unbounded. It is useful even when all quantities are known exactly. By itself, an interval is not a probability distribution, confidence interval, credible interval, measurement claim, or general model of ignorance.

Broader uncertainty may involve indefinitely many interacting or nested ε-like regions, unknown resolution conditions, unknown containment depth, and strategically distorted information. No such general theory is claimed or forced into this library.

The package also does not assume that the usual numeric sequence of operations is conceptually fundamental. Addition, pointwise multiplication, tensor product, matrix action, convolution, intersection, pullback, and change of basis are different constructions. See [What operations on intervals mean](docs/OPERATION-ONTOLOGY.md).

## Source

- `idric/Interval/Exact.idric`: exact rational endpoints; empty, open, closed and unbounded intervals; membership, addition, subtraction and intersection.
- `idric/Interval/Relation.idric`: typed separation and overlap results.
- `idric/Interval/Product.idric`, `Reciprocal.idric`, and `Division.idric`: optional exact images under particular scalar maps, not the minimal ontology of an interval.
- `idric/Interval/Membership.idric`: proposition-level membership corresponding to executable `contains`.
- `idric/Interval/Check.idric`: concrete propositions checked by Idriç.
- `intervals-idric.ipkg`: package for the pinned contemporary Idriç compiler.
- `docs/OPERATION-ONTOLOGY.md`: why operations require mathematical justification rather than an automatic arithmetic tower.
- `docs/SEMANTICS.md`: mathematical meaning and limitations.
- `docs/IDRIC-PRIMARY.md`: language ownership and verification boundary.

The repository deliberately has no second implementation in generic Idris 2. Idriç is the maintained language and acceptance boundary. A host-level Idriç pass still does not establish direct Android, ARM, DEX, GPU, or other target-backend execution.

Concrete `Refl` fixtures establish particular reductions, not the general correctness theorems listed in [issue #1](https://github.com/dilapidated-shed/intervals.idr/issues/1) and the reference-code proof map. Several current universal theorems use proof-oriented scalar models; a checked bridge to production `ExactRational` remains necessary before those theorems can be advertised as proofs of the production arithmetic.

See also [Idriç issue #30](https://github.com/isomorphisms/Idric/issues/30).