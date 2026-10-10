# Sign-sensitive unbounded multiplication

The product of two nonempty real intervals is connected because multiplication is continuous on the connected Cartesian product of the two intervals. Its finite or infinite extrema still require explicit sign analysis.

## Infinite directions

A product is unbounded below when an unbounded magnitude can be paired with an opposite-sign nonzero value:

```text
(+∞) × negative
(-∞) × positive
negative × (+∞)
positive × (-∞)
```

It is unbounded above for the same-sign combinations.

The implementation records four properties of each validated span:

- whether it extends toward negative infinity;
- whether it extends toward positive infinity;
- whether it contains negative values;
- whether it contains positive values.

These determine whether the result has an infinite lower or upper bound.

## Remaining finite extrema

Every finite endpoint is retained even when the opposite side is unbounded. The implementation forms every available finite endpoint product, combines equal extrema using endpoint attainment, and includes a zero candidate whenever either nonempty factor actually contains zero.

The zero rule matters because `0` can be attained through an interior point rather than an endpoint pair. It also gives the exact result

```text
(-∞,+∞) × [0,0] = [0,0]
```

without inventing a value for a formal `0 × ∞`. Interval multiplication concerns products of finite members of sets; infinity is only boundary notation.

## Examples

```text
[0,+∞) × [2,3]       = [0,+∞)
(0,+∞) × (0,2)       = (0,+∞)
(-∞,-1] × [2,3]      = (-∞,-2]
(-∞,-1] × (-∞,-2]    = [2,+∞)
(-∞,0) × (-∞,0)      = (0,+∞)
(0,+∞) × (-∞,0)      = (-∞,0)
[-1,+∞) × [2,+∞)     = (-∞,+∞)
(-∞,+∞) × [2,2]      = (-∞,+∞)
```

## Fail-closed guard

`interval_product_result` still contains `unbounded_product_deferred`. After this implementation it is only an internal fail-closed branch for a malformed candidate state: a finite product boundary was required but no finite endpoint or attained zero candidate was available.

The checked cases do not constitute a universal proof that the guard is unreachable for every `ValidBounds` combination. That theorem belongs with the general multiplication soundness/completeness proof.

Dimensions and units do not enter this arithmetic layer.
