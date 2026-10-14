# Scalar action versus interval-by-interval product

Two operations that both use the symbol `×` have different mathematical roles.

## Scalar action

A scalar acts on an interval:

```text
r · A = { r a | a ∈ A }
```

This is natural once the underlying ordered line is regarded as a module over its scalar ring. Only one operand is uncertain or set-valued. The action has familiar structural laws:

```text
1 · A = A
0 · A = {0}       when A is nonempty
r · ∅ = ∅
(rs) · A = r · (s · A)
r · (A + B) = r · A + r · B
```

A positive scalar preserves order and endpoint orientation. A negative scalar reverses order and exchanges the lower and upper boundaries. Zero collapses every nonempty interval to the closed singleton `[0,0]`.

`Interval.ScalarAction` treats this as part of the useful core API.

## Pointwise product of two intervals

For two intervals, the implemented operation is:

```text
A ⊙ B = { a b | a ∈ A, b ∈ B }
```

Categorically, this is the direct image of the cartesian product `A × B` under a separately chosen multiplication map:

```text
A × B ── multiplication ──▶ scalar line
```

It is therefore not intrinsic to intervals. It is meaningful only when the underlying quantities themselves admit a multiplication that the caller intends to use. Examples include enclosure of an uncertain product, nonlinear polynomial range evaluation, or multiplying two scalar-valued factors.

It is **not** the same construction as:

- scalar action;
- cartesian product of regions;
- tensor product;
- matrix multiplication or composition of linear maps;
- contraction against a basis;
- convolution;
- intersection or restriction.

The existing implementation remains available because it is mathematically coherent and sometimes useful. The clearer API name is `pointwise_product` in `Interval.PointwiseProduct`. It is excluded from `intervals-idric-core.ipkg` and remains in the aggregate package as an optional derived operation.

## Design rule

Do not infer an operation merely from the carrier type. Name the map or action that sends the inputs to the output, and keep different products distinct even when conventional notation reuses `×`.
