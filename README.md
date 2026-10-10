# intervals.idr

An exact rational interval library written in Idriç. The project is a concrete numerical and type-system convenience, comparable to units of measure; it is **not a foundation for incomplete knowledge**.

An interval represents a connected, convex subset of an ordered line, potentially empty or unbounded. It is useful even when all quantities are known exactly. By itself, an interval is not a probability distribution, confidence interval, credible interval, measurement claim, or general model of ignorance.

Broader uncertainty may involve indefinitely many interacting or nested ε-like regions, unknown resolution conditions, unknown containment depth, and strategically distorted information. No such general theory is claimed or forced into this library.

## Core structure

The core package contains interval structure and operations that do not require treating a second interval as a multiplicative factor:

- exact rational endpoints;
- empty, open, closed, half-open and unbounded intervals;
- proof-carrying valid spans;
- executable and proposition-level membership;
- interval relations, addition, negation, subtraction and intersection;
- exact rational **scalar action** on intervals.

Scalar action has the form

```text
scalar · interval
```

A positive scalar preserves order, a negative scalar reverses the endpoints, zero collapses every nonempty interval to `[0,0]`, and every scalar preserves the empty interval.

Build this layer with:

```sh
idris2 --build intervals-idric-core.ipkg
```

## Optional pointwise product

The aggregate package also includes the direct image

```text
{ left × right | left ∈ A, right ∈ B }
```

under the name `pointwise_product`. This is a coherent operation when the underlying quantities themselves have a meaningful multiplication, but it is **not intrinsic interval structure**. It is distinct from scalar action, cartesian product, tensor product, matrix composition, contraction, convolution and intersection.

The reciprocal and division modules remain alongside this optional nonlinear/range-enclosure layer. They are not dependencies of `intervals-idric-core.ipkg`.

See [`docs/SCALAR-ACTION-AND-POINTWISE-PRODUCT.md`](docs/SCALAR-ACTION-AND-POINTWISE-PRODUCT.md).

## Source

- `idric/Interval/Exact.idric`: exact rational endpoints and core interval structure.
- `idric/Interval/ScalarAction.idric`: exact scalar action on intervals.
- `idric/Interval/Membership.idric`: proposition-level membership corresponding to executable `contains`.
- `idric/Interval/Relation.idric`: typed interval relations.
- `idric/Interval/PointwiseProduct.idric`: explicit optional name for interval-by-interval scalar product images.
- `intervals-idric-core.ipkg`: core package without interval-by-interval multiplication.
- `intervals-idric.ipkg`: aggregate package including optional product, reciprocal, division and proof experiments.
- `reference-code/`: pinned Lean Mathlib and Isabelle/HOL AFP references with integrity checks.
- `docs/SEMANTICS.md`: mathematical meaning and limitations.
- `docs/IDRIC-PRIMARY.md`: language ownership and verification boundary.

The repository deliberately has no second implementation in generic Idris 2. Idriç is the maintained language and acceptance boundary. A host-level Idriç pass still does not establish direct Android, ARM, DEX, GPU, or other target-backend execution.

Concrete `Refl` fixtures establish particular reductions, not every general correctness theorem listed in [issue #1](https://github.com/dilapidated-shed/intervals.idr/issues/1) and the reference-code proof map.

See also [Idriç issue #30](https://github.com/isomorphisms/Idric/issues/30).
