# From reference implementations to local proof obligations

The upstream systems below already provide nontrivial proofs. Their statements and assumptions must be checked in the linked source; similar names do not make our implementation equivalent.

| Our unproved goal | Upstream entry point | Remaining local work |
| --- | --- | --- |
| Represent empty, unbounded and each open/closed interval without invalid spans | Mathlib `Set.Icc`, `Set.Ioo`, `Set.Ioc`, `Set.Ico` in `Defs.lean`; emptiness in `Basic.lean` | Make `Interval` constructors private or proof-indexed, including nonempty/open-singleton distinctions |
| Soundness of addition for every member (`a∈A, b∈B ⟹ a+b∈addInterval A B`) | Mathlib pointwise `Icc_mul_Icc_subset'`, with `@[to_additive Icc_add_Icc_subset]` generating additive variants | Derive the corresponding theorem for **our** exact rational implementation and each endpoint kind |
| Completeness of addition (`z∈addInterval A B ⟹ ∃a∈A,b∈B,z=a+b`) | Mathlib order/pointwise set machinery | Prove separately under appropriate densely ordered / additive hypotheses; mere inclusion does not suffice |
| Preserve set inclusion under arithmetic | AFP `Inclusion_Isotonicity.thy` | Define a proven inclusion order on our valid intervals, then establish isotonicity |
| Explicit zero-crossing and unbounded division semantics | AFP `Extended_Interval_Division.thy` | Decide whether ordinary division is partial, set-valued multi-interval, or extended, rather than silently divide by zero |
| Source-sensitive expressions, particularly `x−x` | AFP `Affine_Arithmetic/Affine_Form.thy` | A syntactic interval subtraction `A−A=[-1,1]` is only a coarse enclosure for correlated occurrences; introduce expression identity or affine forms with verified operations |
| General real-expression enclosure | NASALib PVS `interval_expr.pvs`: `Eval_fundamental`, `Eval_inclusion`; proof evidence in `interval_expr.prf` | Connect an expression's concrete evaluation and interval interpretation to a soundness theorem for Idriç |
| Correct finite-precision interval arithmetic | Coq/Rocq Interval, verified bounds and floating-point support; NASALib interval strategies | Implement correctly rounded Float16/Float32 directed endpoints in a maintained Idriç backend; no host-Double substitution |

## Epistemic correctness is another theorem family

The reference mathematics does not automatically prove that an observation, a bound, a confidence interval, or a Bayesian credible interval has the claimed empirical interpretation.

An intended information-preservation theorem for future work is:

1. Every derived `HasBounds` result retains an inspectable provenance path to its inputs and their bound meanings.
2. `NoBounds` caused by an unestablished measurement, model or calibration does not silently become a known bound.
3. Derived set inclusion does not imply statistical coverage. A confidence-interval statement requires a sampling design and a coverage theorem; Bayesian credible intervals require a posterior/model.

Our current tests check specific reductions with `Refl`, **not universal theorems** and not empirical model calibration.
