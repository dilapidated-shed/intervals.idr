# Reciprocal shape and exact division

The reciprocal of a connected interval is not always connected.

For a finite interval away from zero, reciprocal reverses the endpoint order:

```text
[2,4]      ↦ [1/4,1/2]
(2,4]      ↦ [1/4,1/2)
[-4,-2]    ↦ [-1/2,-1/4]
```

An interval with zero as one endpoint becomes a ray after zero is removed from the reciprocal domain:

```text
[0,2]      ↦ [1/2,+∞)
(0,2)      ↦ (1/2,+∞)
[-2,0]     ↦ (-∞,-1/2]
```

An interval crossing zero becomes two disjoint rays:

```text
[-2,3]     ↦ (-∞,-1/2] ∪ [1/3,+∞)
(-2,3)     ↦ (-∞,-1/2) ∪ (1/3,+∞)
```

The closed zero singleton has no reciprocal values, and the empty interval remains empty.

## Unbounded input intervals

Unbounded inputs now have exact reciprocal components as well:

```text
(-∞,-2]    ↦ [-1/2,0)
(-∞,0]     ↦ (-∞,0)
(-∞,2]     ↦ (-∞,0) ∪ [1/2,+∞)
[2,+∞)     ↦ (0,1/2]
[0,+∞)     ↦ (0,+∞)
[-2,+∞)    ↦ (-∞,-1/2] ∪ (0,+∞)
(-∞,+∞)    ↦ (-∞,0) ∪ (0,+∞)
```

The limit value zero is excluded whenever it arises only from `|x| → ∞`.
Endpoint membership at a finite nonzero bound is reversed to the corresponding reciprocal boundary without otherwise changing inclusion.

## Idriç result type

`Interval.Reciprocal` returns:

```idric
choice reciprocal_result one_of
  reciprocal_empty
  reciprocal_connected exact_interval
  reciprocal_split exact_interval exact_interval
  reciprocal_unbounded_deferred
```

All valid empty, finite, one-sided-unbounded and two-sided-unbounded intervals are now classified exactly. `reciprocal_unbounded_deferred` remains only as a fail-closed compatibility branch; `reciprocal_interval` no longer returns it for the current validated interval representation.

## Exact rational representation

For a nonzero exact rational `n/d`, reciprocal is represented as:

```text
 d/|n|   when n > 0
-d/|n|   when n < 0
```

The denominator remains positive by construction. `reciprocal_rational 0` returns `Nothing`.

## Division

`A ÷ B` multiplies `A` by every connected component of `reciprocal_interval B`, then normalizes overlapping or touching products. This supports unbounded divisors as well as finite divisors crossing zero.

Representative consequences include:

```text
[1,2] / (-∞,+∞) = (-∞,0) ∪ (0,+∞)
[0,1] / (-∞,+∞) = (-∞,+∞)
[2,4] / [2,+∞)  = (0,2]
[2,4] / (-∞,-2] = [-2,0)
```

The checked reductions are not yet a general proof that the returned components equal `{1/x | x ∈ I, x ≠ 0}` or that normalized quotient components equal the set-theoretic quotient. Those theorems belong in the arithmetic proof layer and should use `IntervalMember` rather than a second unrelated membership definition.
