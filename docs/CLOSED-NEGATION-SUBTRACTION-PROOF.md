# Universal closed-interval negation and subtraction enclosure

The proof-oriented `ClosedDifferenceInterval` layer now supports addition, negation and subtraction with open-variable membership theorems.

## Negation

For a valid closed interval

```text
[lower, upper]
```

negation reverses both order and endpoint position:

```text
-[lower, upper] = [-upper, -lower].
```

The theorem

```idric
negation_encloses_closed_member
```

proves that every member `x` of the source interval gives a member `-x` of the negated interval. Its lower proof is obtained by reversing `x ≤ upper`; its upper proof is obtained by reversing `lower ≤ x`.

## Subtraction

Closed interval subtraction is defined by addition of the negated right interval:

```text
[left_lower, left_upper] - [right_lower, right_upper]
=
[left_lower-right_upper, left_upper-right_lower].
```

The theorem

```idric
subtraction_encloses_closed_members
```

proves, for arbitrary intervals and arbitrary proposition-level members,

```text
x ∈ A and y ∈ B
implies
x-y ∈ A-B.
```

It composes the universal negation theorem with the previously proved universal addition theorem. No new scalar axiom is introduced.

## Boundary

These are soundness/enclosure theorems for closed intervals over structural signed differences. They do not yet establish converse decomposition, open endpoint semantics, or correspondence with every primitive `ExactRational` computation. They strengthen the reusable proof model without changing the production interval API.

Dimensions and units are unrelated to these order arguments.
