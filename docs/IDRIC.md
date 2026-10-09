# Idriç integration contract (not compiled Idriç source)

This repository began with an empty notebook in August 2026. By October, the maintained Idriç source grammar, numerical widths, `≟` equality, `Number`, `Text`, explicit `÷`, direct backends, and acceptance boundaries had substantially changed. The exact core is therefore kept in an ordinary `.idr` Idris 2 compatibility module; it is **not** passed off as present-day Idriç `.idric` code.

## Proposed semantic surface

The language-facing intention, not a claimed parser fixture:

```idric
-- Source spellings are provisional.  Semantic relationships are the contract.
interval_of possible_values between lower and upper
known_bound ← bound with provenance from observation
missing_bound ← unresolved because calibration_not_established

sum_of_bounds ≝ add bounds from first_input to second_input
```

A future Idriç `.idric` integration must tie the following into its checked core:

- `Interval (Quantity dimension)`: addition takes two intervals of the **same** dimension and returns that dimension; unlike quantities cannot be added.
- `NoBounds`: an epistemic missing state; not a numeric zero, `NoPoints`, a full interval or a distribution.
- `Provenance`: source identities retained through operations and invalidation/replay of source-derived reports.
- `contains`/subsetting and physical assertions: keep truth/evidence status distinct from machine `Bool` when observation/model ambiguity matters.
- `Interval Float16` / `Interval Float32`: provide checked directed-rounding kernels before claiming any enclosing result.
- Expression correlation: `x−x` must not be simplified from naive interval subtraction until source identity and expression-equality proofs make that justified.
- No substitution of Idris, Python, RefC, host floating point, or a reference result for an Idriç backend execution.

Current language authority: [Idriç STYLE.md](https://github.com/isomorphisms/Idric/blob/Idri%C3%A7/STYLE.md), [Idriç interval issue](https://github.com/isomorphisms/Idric/issues/30), and the [units/time/interval fixture](https://github.com/isomorphisms/Idric/blob/Idri%C3%A7/_/examples/units-time-intervals/UnitsTimeIntervals.idric).
