# Verified Idriç source acceptance

## Exact accepted revisions

- **intervals.idr source head:** `201c199415fbd55528d7a5ec46c43b20a1dfc665`
- **Idriç compiler:** `94dfd99bd3e376507fedc8611053b7173b2519f0` from the default `Idriç` branch
- **workflow run:** [38023465560](https://github.com/dilapidated-shed/intervals.idr/actions/runs/38023465560)

## Acceptance steps

The workflow checked out the exact proposed source head rather than GitHub's synthesized merge ref, restored the pinned compiler build, and supplied the compiler's built package, backend-data, and support-library paths.

It then ran:

```text
<Idriç compiler>/idris2 --build intervals-idric.ipkg
./build/exec/interval-idric-tests
```

Results:

```text
Building Interval.Exact
Building Interval.Check
Now compiling the executable: interval-idric-tests
Idriç exact rational interval checks: PASS
```

The canonical Idriç source-style action also passed on that exact source head.

## Evidence boundary

This receipt establishes host-level parsing, elaboration, typechecking, executable emission through the pinned Idriç compiler's Chez path, and execution of the concrete `Refl` fixture program.

It does **not** establish:

- universal mathematical correctness of interval arithmetic;
- direct ARM32, DEX/ART, x86-64, GPU, Wasm, or other maintained target execution;
- Float16 or Float32 outward rounding;
- correlation-aware simplification such as proving a repeated expression `x−x` is exactly zero;
- any statistical interpretation of an interval.

A compiler-pin change, backend claim, or stronger mathematical theorem requires a new exact receipt.
