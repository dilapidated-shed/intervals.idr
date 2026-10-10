# Idriç interval source

- `idric/Interval/Exact.idric` is the implementation. It uses Idriç `choice` declarations for interval and boundary variants, `Number`/`±Number`, `→`, `×`, and `≟` notation, with domain names that state the mathematics.
- `idric/Interval/Check.idric` contains concrete propositions about endpoint membership and exact arithmetic.
- `intervals-idric.ipkg` is compiled only with the pinned contemporary Idriç compiler.

There is no parallel generic Idris 2 implementation. Keeping one language and one source of truth matters more than retaining an easier fallback.

An interval is a useful one-dimensional mathematical type, comparable to typed units. It is **not** the foundational representation for unknown unknowns, interacting epsilon regions, unknown nesting depth, or strategically distorted knowledge.

## Proof boundary

Concrete `Refl` equalities are not universal enclosure or completeness theorems. The exported `points_between` alternative also still permits callers to bypass `make_interval`; a future proof-indexed representation should make malformed intervals unconstructible.

Idriç source acceptance uses the exact compiler revision recorded in `IDRIC-COMPILER-RECEIPT.md`. Direct CPU, GPU, Android, DEX, or other target execution is a further and separate claim.
