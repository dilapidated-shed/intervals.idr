# intervals.idr

Exact intervals and typed missing-bound/provenance semantics for eventual integration with [Idriç](https://github.com/isomorphisms/Idric) and [Econometrician-in-a-Box](https://github.com/bl4ckb4ll/econometrician).

An **interval** represents a set of possible values. By itself, it is not a probability distribution, confidence interval, credible interval, measurement claim, or evidence of Gaussian error. `NoBounds` records missing information without substituting zero, the empty interval, an unbounded interval, or a guessed prior.

## Initial implementation

- `src/Interval/Exact.idr`: exact rationals with structurally positive denominator; finite/unbounded endpoints, open/closed membership, emptiness, Minkowski addition, interval subtraction, and intersection.
- `src/Interval/Evidence.idr`: distinguishes explicitly reported bounds from unavailable bounds and retains source identities through addition.
- `src/Interval/Tests.idr`: compile-time equality witnesses for endpoint behavior, arithmetic, unboundedness, dependency loss, missing information, and source propagation.
- `docs/SEMANTICS.md`: mathematical assumptions, distinctions from statistical intervals, and known limitations.
- `docs/IDRIC.md`: intended bridge to the **current** Idriç language, not a claimed compiler integration.

The code here uses Idris 2 **compatibility** syntax (`.idr`). It is not a claim that the maintained Idriç compiler has accepted `.idric` source or produced a machine executable.

## Check

With Idris 2 and its standard library installed:

```sh
idris2 --build intervals.ipkg
./build/exec/interval-tests
```

The compilation is the essential proof check: `Refl` fixtures do not merely print that they pass. Backend execution must also succeed to claim the runnable test program works. CI uses a separate compiler environment and must be checked against the actual PR commit.

See [design issue #1](https://github.com/dilapidated-shed/intervals.idr/issues/1) and [Idriç issue #30](https://github.com/isomorphisms/Idric/issues/30).
