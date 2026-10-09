# Idriç primary interval source

- The **maintained** code is `idric/Interval/Exact.idric`. It uses modern Idriç `choice` declarations for interval and boundary variants, `Number`/`±Number`, `→`, `×`, and `≟` notation, plus source names that describe the mathematics.
- `idric/Interval/Check.idric` contains concrete, proof-checked propositions about endpoint membership and exact arithmetic.
- `intervals-idric.ipkg` is the package for the actual Idriç compiler.
- `src/Interval/*.idr` and `intervals.ipkg` are retained as **Idris 2 compatibility/reference tests**, not as the primary design language. Their evidence must not be presented as Idriç acceptance.

An interval is simply a useful one-dimensional mathematical type, comparable to typed units. It is **not** the foundational representation for unknown unknowns, interacting epsilon regions, unknown nesting depth, or strategically distorted knowledge.

**Proof boundary:** Concrete `Refl` equalities are not universal enclosure/completeness theorems; the exported `points_between` constructor still permits users to bypass the validation entrypoint. A future proof-indexed interface should make malformed intervals unconstructible.

For Idriç acceptance, compile the `.idric` package with the [current Idriç compiler](https://github.com/isomorphisms/Idric/tree/Idri%C3%A7), pinned to a specific commit. Building `src/*.idr` with generic Idris 2 proves only the compatibility slice. Direct CPU/GPU/Android target execution is a further, separate claim.
