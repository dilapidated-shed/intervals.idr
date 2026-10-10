# Formal interval reference code

These are **complete, unchanged source files** from upstream formalizations, pinned to immutable revisions.
They are for reading and comparisons, **not** dependencies of the Idriç implementation. Vendored source does not independently compile here and is not an assertion that our own interval arithmetic has been proved correct.

## Where the code is

| Folder | System | What to inspect |
| --- | --- | --- |
| `mathlib4/Mathlib/Order/Interval/Set/Defs.lean` | Lean 4 / Mathlib | `Ioo`, `Ioc`, `Ico`, `Icc`, infinite endpoints, membership |
| `mathlib4/Mathlib/Order/Interval/Set/Basic.lean` | Lean 4 / Mathlib | Empty/open/singleton boundary laws and inclusion |
| `mathlib4/Mathlib/Algebra/Order/Group/Pointwise/Interval.lean` | Lean 4 / Mathlib | Pointwise interval arithmetic, including the `@[to_additive]` companion of `Icc_mul_Icc_subset'` |
| `afp/thys/Interval_Analysis/Inclusion_Isotonicity.thy` | Isabelle/HOL AFP | Inclusion isotonicity as a general correctness condition |
| `afp/thys/Interval_Analysis/Extended_Interval_Division.thy` | Isabelle/HOL AFP | Division in extended interval arithmetic and reciprocal semantics |
| `afp/thys/Affine_Arithmetic/Affine_Form.thy` | Isabelle/HOL AFP | Noise-symbol/affine-form machinery relevant to the `x - x` dependency problem |

## Reproducibility

Every copied file retains its original text, copyright notice when present, and **upstream Git blob SHA-1** in `SOURCES.json`. The entire upstream revision is pinned separately.

From anywhere in the repository (no working-directory assumption):

```sh
python3 reference-code/verify.py
```

or from inside `reference-code/`: `python3 verify.py`. It recomputes each Git blob identifier and checks for unexpected modification. The GitHub workflow checks these hashes without network access.

## Other relevant formalisms

- NASA [NASALib PVS interval arithmetic](https://github.com/nasa/pvslib/tree/b54fa2a1791a5dc96603f8c97a161263a5621257/interval_arith), notably `Eval_fundamental` and `Eval_inclusion` in `interval_expr.pvs`, plus its proof record `interval_expr.prf`. The repository-wide NASA notice points to potentially different terms for contributions; it is **not vendored** pending review of that licensing.
- [Coq/Rocq Interval](https://gitlab.inria.fr/coqinterval/interval): version `4.11.4`, checksummed release, licensed CeCILL-C. It is **not vendored**; see the archive lock in `SOURCES.json`.

For a pinned, verified **optional local retrieval** of the NASA PVS and Coq sources:

```sh
python3 reference-code/fetch_optional.py
```

The script saves those artifacts beneath the git-ignored `reference-code/external/`. It does not import or run them. GitHub checks do not download optional sources.

## Licenses and origin

- The Mathlib copies are Apache-2.0; the complete upstream license is copied unchanged to `mathlib4/LICENSE`. Source headers are preserved.
- The AFP entries `Interval_Analysis` and `Affine_Arithmetic` are labeled `bsd` in their upstream entry metadata. Their source files are unchanged and retain their original headers. Authors: Achim D. Brucker and Amy Stell for Interval Analysis; Fabian Immler for Affine Arithmetic. [AFP licensing](https://isa-afp.org/about/).
- The **license of this repository's own code is not set by including reference material.** Do not copy code from the reference folder into Idriç without retaining appropriate notices.

See `PROOF-MAP.md` for the exact gap between these upstream results and the theorems we still need to prove in `Interval.Exact`.
