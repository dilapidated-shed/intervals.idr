# Exact bounded interval multiplication

`Interval.Product` implements exact multiplication when both nonempty inputs have finite rational endpoints.

## Why this slice is separate

The numerical endpoints of a finite product are the minimum and maximum of the four corner products:

\[
ac,\quad ad,\quad bc,\quad bd
\]

for input intervals with numeric endpoints \(a \le b\) and \(c \le d\). This handles positive, negative and sign-crossing ranges without case-splitting by hand.

Endpoint membership needs more care:

- a nonzero extremum is included when at least one corner attaining it uses two included endpoints;
- equal corner products combine their attainment information;
- zero can be attained through an interior point. For example, `[0,1] × (0,1)` contains `0` even though the open interval's endpoint `0` is excluded;
- multiplying by the closed singleton `[0,0]` gives `[0,0]` for every nonempty bounded interval.

The checked fixtures cover those cases.

## Deliberate unbounded boundary

```idric
multiply_if_bounded :
  exact_interval →
  exact_interval →
  Maybe exact_interval
```

- `Just product` is an exact result.
- `Nothing` means at least one **nonempty** operand is unbounded.
- An empty operand still returns `Just no_points`, even when the other operand is unbounded.

`Nothing` does not mean the mathematical product is undefined. It records that the current implementation has not yet supplied all sign-sensitive infinity cases, particularly the interaction between zero and unbounded ranges. This is preferable to silently returning an over-wide or wrong interval.

## Still unproved

The `Refl` fixtures establish concrete reductions. They do not yet prove the general set equality

\[
\{xy \mid x\in A,\ y\in B\}
=
\operatorname{multiply\_finite\_spans}(A,B).
\]

That proof should connect corner extrema, endpoint attainment and the zero-interior rule to `contains`.

Division remains separate. If a divisor interval contains zero, the quotient may require two disjoint rays rather than one connected interval, so ordinary `exact_interval` is not automatically the correct result type.
