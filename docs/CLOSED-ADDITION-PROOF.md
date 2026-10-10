# Universal closed-interval addition enclosure

`Interval.ClosedDifference` contains the first general interval-arithmetic theorem in this repository.

## Scalar model

The theorem is proved over `SignedDifference`, where

```text
Difference positive negative
```

denotes `positive − negative`. Order is proof-level cross-sum order:

```text
p − n ≤ q − m  iff  p + m ≤ q + n.
```

This representation is intentionally noncanonical. Its purpose is to expose the addition/order laws needed by the proof rather than rely on unproved properties of primitive machine integers.

## Closed intervals and membership

A `ClosedDifferenceInterval` stores:

- a lower signed difference;
- an upper signed difference;
- a proof that the lower value is no greater than the upper value.

`ClosedDifferenceMember value interval` stores proofs that

```text
lower interval ≤ value
value ≤ upper interval.
```

## The theorem

```idric
addition_encloses_closed_members :
  (left_interval, right_interval : ClosedDifferenceInterval) →
  (left_member, right_member : SignedDifference) →
  ClosedDifferenceMember left_member left_interval →
  ClosedDifferenceMember right_member right_interval →
  ClosedDifferenceMember
    (add_difference left_member right_member)
    (add_closed_difference_intervals left_interval right_interval)
```

The lower inequality follows from monotonicity of addition:

```text
left_lower ≤ left_member
right_lower ≤ right_member
--------------------------------
left_lower + right_lower ≤ left_member + right_member
```

The upper inequality is analogous. The theorem is open in both intervals and both member values; its acceptance is not a finite list of endpoint examples.

## Exact boundary of the result

This is the **soundness/enclosure direction** for closed intervals over structural signed integers:

```text
x ∈ A and y ∈ B  implies  x+y ∈ endpoint_sum(A,B).
```

It does not yet prove the converse decomposition theorem

```text
z ∈ endpoint_sum(A,B)  implies  there exist x∈A, y∈B with z=x+y.
```

Nor does it yet cover rational denominators, open endpoints, or unbounded bounds. The next bridge should lift the signed scalar laws to positive-denominator rationals and then connect this theorem to the production `ExactRational` interval representation.

Units and dimensions are unrelated to this proof and remain optional later integration.
