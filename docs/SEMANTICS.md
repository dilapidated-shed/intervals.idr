# Semantics and boundaries

Status: Idris 2 compatibility sources and their concrete `Refl` fixtures compiled, and the test program executed on commit `622328d0` in [CI run 37964371440](https://github.com/dilapidated-shed/intervals.idr/actions/runs/37964371440). These are **not general correctness proofs**. No maintained Idriç backend execution is claimed.

## Scope: a useful special case, not a theory of ignorance

Intervals are low-complexity, high-value mathematical types, like units of measure. The fact that an interval can encode a finite range of possible values **does not make it the foundational representation of not knowing**. Such a foundation is a separate, open inquiry.

In particular, an exploratory model involving arbitrarily many ε-like regions, potentially unknown or recursive containment depth (`((•))`, `(((((•)))))`), unknown resolution conditions, interactions between regions, and unknown unknowns cannot be assumed to reduce to this library's one-dimensional interval structure. Nothing here assumes those ε objects are nilpotent dual numbers, ordinary interval widths, probability distributions, or a fixed-depth tree. Nor does this library model the distortion or strategic presentation of knowledge through propaganda or marketing. Do not force any of these phenomena into `NoBounds` or `HasBounds` simply for convenience.

## What an interval means

An interval is a subset of an **ordered, linear** scalar domain. It can be empty, bounded with independently included/excluded endpoints, or unbounded on either end. `[a,b]`, `(a,b)`, `[a,b)`, and `(a,b]` have distinct membership. For equal finite endpoints, only `[a,a]` has a member.

Operations in `Interval.Exact` are exact rational operations:

- **Minkowski addition**: `[1,3] + [4,9] = [5,12]`. An endpoint is included in a sum only when both contributing endpoints are included.
- **Subtraction**: `[1,3] − [4,9] = [-8,-1]`, negating the second interval before addition.
- **Intersection**: restrict to common members. A coincident endpoint stays included only if both intervals include it.
- **Membership, emptiness, open-left/open-right**: bounded and unbounded cases.

The rational denominator is positive by construction (`OnePlus n` represents `n+1`). Equal rationals need not share a stored normalized numerator/denominator; all comparisons use exact cross multiplication. No floating rounding or interval division is implemented.

`x:[0,1]; x−x` yields `[-1,1]` **in interval arithmetic**. That is an enclosure under independent-occurrence propagation, not a claim that the occurrences are independent random variables. Proving the same symbolic source appears twice would yield exactly `0` in a richer correlation-aware calculus. Expression identity, affine/constraint-aware methods, and covariance remain open and are NOT simulated here.

## Epistemic boundary

`Interval.Evidence` introduces `BoundsKnowledge`:

- `HasBounds meaning range provenance`: an explicitly asserted bound with a reason for its existence;
- `NoBounds reasons provenance`: the bound is missing or unjustified.

`NoBounds` is **not** `NoPoints`, **not** the entire real line, and **not** the singleton zero. Adding an unknown bound to another claim remains unknown and preserves both provenance trees and the purposes of any known input bounds. A returned interval is not automatically a statistical confidence interval.

Keep separate:

| Object | What it actually says |
|---|---|
| Exact nominal definition | A rational chosen by standard/convention; not a measurement of the manufactured object |
| Physical tolerance | Declared allowable departures from a nominal value |
| Instrument/measurement bound | Claimed enclosure conditional on source/calibration; not statistical sampling coverage |
| Finite-data statistic | Arithmetic from specified observations |
| Frequentist confidence interval | A *procedure* with sampling/coverage assumptions, not just endpoints |
| Bayesian credible interval | A posterior probability statement conditional on model, likelihood and prior |
| Bootstrap interval | Depends on resampling unit, design, estimator, method, and validity |
| Model identification region | Values compatible with specified model and evidence |
| Covariance / correlated error | Dependence structure; **not** representable by independent one-dimensional bounds alone |
| Floating rounding enclosure | Must round outward to enclose the exact result |
| Ordered vs dual epsilon | A nilpotent tangent `ε²=0` is not an ordered positive endpoint displacement |

The above table is an ownership/semantic map, **not** a list of implemented constructors or valid inference procedures. In particular, the library does not produce confidence/credible intervals from arbitrary `HasBounds` records.

## Ownership

- `intervals.idr`: exact linear-set interval kernel, explicit missing bounds/provenance, unit-agnostic API. Later: indexed quantities, proof-preserving enclosure and selected numerical operations; statistical reports belong in a statistical consumer unless a specific reusable kernel justifies inclusion.
- [Idriç](https://github.com/isomorphisms/Idric): formalized public type semantics, checking/elaboration, compiler and backend acceptance; the checked language must not silently erase uncertainty.
- [Econometrician-in-a-Box](https://github.com/bl4ckb4ll/econometrician): observations, acquisition/source graph, sampling design, calibration, estimation, conditioning, inference, identification and report semantics. A Python or R numerical oracle does not certify an Idriç execution.
- [Geofence](https://github.com/dilapidated-shed/geofence): may import linear bounds, but longitude/bearing/time-of-day wrap must use an **arc/circular** object, not a fake linear `[start,end]`.

## Constraints on the next pass

1. Hide or proof-index `PointsBetween` to stop external code from bypassing the smart constructor; it is currently publicly representable in the compatibility kernel.
2. Obtain an actual Idris 2 compile/typecheck receipt and then an Idriç source/backend receipt separately. Do not call checks green because a numerical oracle agrees.
3. Preserve units/dimensions by lifting the interval functor over an ordered `Quantity dimension`, rather than erasing dimensionality to a raw rational.
4. Design finite-precision enclosure with actual directed rounding; Float16 and Float32 are distinct and must not silently pass through host `Double`.
5. Only add statistical interval constructors after required study/design/provenance data can be represented. No probability normalization by default.
6. Treat all higher-order uncertainty, unknown containment structures, source manipulation and incomplete model knowledge as outside this module. Do not imply interval arithmetic solves them.
