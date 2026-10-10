# Fixed positive-denominator rational proof layer

`Interval.FixedRational` lifts the structural signed-order proofs to exact rational values whose shared positive denominator is carried in the type.

## Type-indexed denominator

```idric
data FixedRational : PositiveDenominator → Type where
  RationalNumerator :
    SignedDifference →
    FixedRational denominator
```

For a fixed positive denominator `d`, order is exactly order of the signed numerators:

```text
a/d ≤ b/d  iff  a ≤ b.
```

No positivity side condition is reconstructed at each use: `PositiveDenominator` has no zero constructor, and the denominator index guarantees both operands share the same scale.

Addition therefore stays at that denominator:

```text
a/d + b/d = (a+b)/d.
```

This is the mathematically natural representation for a common-denominator proof. It avoids silently coercing unequal denominators or relying on unproved primitive-integer multiplication laws.

## Universal interval theorem

`ClosedFixedRationalInterval d` and `ClosedFixedRationalMember` lift the closed signed-interval proof to a fixed positive rational denominator. The theorem

```idric
fixed_addition_encloses_closed_members
```

is open in:

- the positive denominator `d`;
- both closed intervals;
- both member values;
- both proposition-level membership witnesses.

It proves:

```text
x ∈ A and y ∈ B
implies
x+y ∈ [lower(A)+lower(B), upper(A)+upper(B)]
```

for exact rationals with denominator `d`.

## Production bridge

`fixed_to_exact` converts the proof representation to the production `ExactRational` type by interpreting `Difference positive negative` as the inherited signed integer `positive-negative` and retaining the indexed denominator.

This is a computational bridge, not yet a universal proof that every primitive `Integer` operation implements the structural signed model. The checks establish representative conversion and addition examples, including a noncanonical numerator pair.

## Next bridge

Arbitrary rational denominators require an explicit common-denominator operation. The useful next theorem is that rescaling a signed numerator by a positive factor preserves order, followed by a proof that two rational intervals can be rescaled to a shared product denominator without changing their represented values.

That work is scalar proof infrastructure. Units and dimensions remain optional consumers, not prerequisites.
