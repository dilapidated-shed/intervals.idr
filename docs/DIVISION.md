# Exact set-valued interval division

Division is defined by excluding zero divisors and multiplying by every connected component of the divisor's reciprocal:

\[
A / B = \{x/y \mid x \in A,\ y \in B,\ y \ne 0\}.
\]

Because the reciprocal of a zero-crossing interval has two rays, the quotient need not be connected.

## Result shape

```idric
choice division_result one_of
  division_empty
  division_connected exact_interval
  division_split exact_interval exact_interval
  division_deferred
```

- `division_empty` means no quotient values exist, as with an empty divisor or `[0,0]`.
- `division_connected` carries one exact interval.
- `division_split` carries two ordered components separated by a genuine gap.
- `division_deferred` preserves an explicitly unsupported prerequisite, currently reciprocals of already-unbounded divisors or the product module's fail-closed guard.

## Normalization

Products of two reciprocal components are normalized after multiplication:

- empty components disappear;
- overlapping components merge to their interval hull;
- components touching at a shared numeric boundary merge when either component includes that point;
- components remain split only when a positive-size gap exists or both exclude their common boundary;
- split components are returned in numeric order.

For example:

```text
[0,1) ∪ [1,2] = [0,2]
(0,1) ∪ (1,2) remains split because 1 is missing
```

## Examples

```text
[2,4] / [1,2]      = [1,4]
(2,4] / [1,2]      = (1,4]
[2,4] / [-2,-1]    = [-4,-1]
[2,4] / [0,2]      = [1,+∞)
[2,4] / [-2,0]     = (-∞,-1]
[1,2] / [-1,1]     = (-∞,-1] ∪ [1,+∞)
[0,1] / [-1,1]     = (-∞,+∞)
[0,0] / [-1,1]     = [0,0]
[1,2] / [0,0]      = empty
```

## Proof boundary

The checked Idriç reductions verify these representative cases and the normalization mechanics. They do not yet prove the general set equality above. That proof should use proposition-level `IntervalMember` witnesses and establish that reciprocal, multiplication, and component normalization preserve exactly the intended quotient members.

Units and dimensions are not part of this arithmetic result shape.
