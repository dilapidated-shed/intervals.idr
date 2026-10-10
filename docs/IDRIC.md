# Idriç integration

The maintained implementation now lives directly in:

- [`idric/Interval/Exact.idric`](../idric/Interval/Exact.idric)
- [`idric/Interval/Check.idric`](../idric/Interval/Check.idric)
- [`intervals-idric.ipkg`](../intervals-idric.ipkg)

See [`IDRIC-PRIMARY.md`](IDRIC-PRIMARY.md) for the language and API boundary and [`IDRIC-COMPILER-RECEIPT.md`](IDRIC-COMPILER-RECEIPT.md) for the pinned compiler acceptance contract.

The old proposal in this file mixed interval mathematics with a broader provenance and missing-knowledge system. That is no longer the direction of this repository. Intervals remain a useful special-purpose type, comparable to units of measure.

Future Idriç integration should preserve these relationships:

- an eventual generic `Interval (Quantity dimension)` keeps the dimension in the endpoint type;
- addition accepts intervals over the same additive quantity type;
- Float16 and Float32 interval operations require real outward rounding;
- `x−x` must not gain a correlation-aware simplification unless expression identity or another justified dependency mechanism is present;
- host Idris 2, Python, reference implementations, or a fallback backend cannot substitute for a claimed Idriç or target-backend execution.

Current language authority: [Idriç STYLE.md](https://github.com/isomorphisms/Idric/blob/Idri%C3%A7/STYLE.md), [Idriç issue #30](https://github.com/isomorphisms/Idric/issues/30), and the [units/time/interval fixture](https://github.com/isomorphisms/Idric/blob/Idri%C3%A7/_/examples/units-time-intervals/UnitsTimeIntervals.idric).
