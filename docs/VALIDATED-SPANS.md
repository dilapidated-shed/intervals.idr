# Proof-carrying interval spans

A nonempty interval should not be representable as two arbitrary endpoints.

The `prelude/proof-carrying-valid-spans` layer replaces

```idric
points_between lower_bound upper_bound
```

with a `ValidatedSpan`. Its erased `ValidBounds lower upper` argument proves one of the cases that can actually contain a rational number:

- the whole line;
- one-sided unbounded intervals;
- finite endpoints with `lower < upper`, regardless of endpoint inclusion;
- equal finite endpoints only when both endpoints are included.

Reversed finite bounds and open or half-open singletons have no `ValidBounds` constructor. `make_interval` therefore returns `no_points` for them, while direct construction requires evidence rather than trusting a caller convention.

The evidence is multiplicity `0`: it constrains typechecking but is absent from the runtime interval representation.

## What this establishes

This representation makes malformed nonempty spans unconstructible through the exported API, assuming the consistency of the Idriç core and the exact Boolean order procedures used by the proofs.

It does **not** yet prove:

- that `contains` exactly denotes the mathematical set associated with every span;
- soundness or completeness of addition, subtraction, or intersection;
- dense-order existence for every strict open rational interval;
- any Float16 or Float32 enclosure property;
- any statistical or epistemic interpretation.

Those are separate theorem families. The reference-code proof map identifies relevant Lean and Isabelle developments without treating their proofs as proofs about this implementation.
