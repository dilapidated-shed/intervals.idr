# Reciprocal shape and future division

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

## Idriç result type

`Interval.Reciprocal` therefore returns:

```idric
choice reciprocal_result one_of
  reciprocal_empty
  reciprocal_connected exact_interval
  reciprocal_split exact_interval exact_interval
  reciprocal_unbounded_deferred
```

This type records the first unavoidable reason ordinary interval division cannot always return one `exact_interval`.

## Exact rational representation

For a nonzero exact rational `n/d`, reciprocal is represented as:

```text
 d/|n|   when n > 0
-d/|n|   when n < 0
```

The denominator remains positive by construction. `reciprocal_rational 0` returns `Nothing`.

## Deliberate boundary

This slice handles finite input intervals. Reciprocals of already-unbounded intervals remain explicit as `reciprocal_unbounded_deferred`; their zero/sign cases should be added before full division.

Future `A ÷ B` should multiply `A` by each connected component of `reciprocal_interval B`, then normalize overlapping or touching products. That likely requires a small canonical finite-union type rather than reusing a pair of intervals blindly.

The current checked reductions are not yet a general proof that the returned components equal `{1/x | x ∈ I, x ≠ 0}`. That theorem belongs in the arithmetic proof layer and should use `IntervalMember` rather than a second unrelated membership definition.
