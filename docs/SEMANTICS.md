# Semantics and boundaries

The Idris 2 compatibility sources and their concrete `Refl` fixtures have compiled and executed in CI. Those fixtures are **not general correctness proofs**. Idriç acceptance and any direct target-backend execution remain separate claims.

## Scope: a useful special case, not a theory of ignorance

Intervals are low-complexity, high-value mathematical types, like units of measure. The fact that an interval can encode a range of possible values does **not** make it the foundational representation of not knowing.

A broader model may involve arbitrarily many ε-like regions, unknown or recursive containment depth (`((•))`, `(((((•)))))`), unknown resolution conditions, interactions between regions, unknown unknowns, and strategic distortion through propaganda or marketing. Nothing here assumes such objects are nilpotent dual numbers, ordinary interval widths, probability distributions, or fixed-depth trees.

## What an interval means

An interval is a connected, convex subset of an **ordered, linear** scalar domain. It can be empty, bounded with independently included or excluded endpoints, or unbounded on either end. `[a,b]`, `(a,b)`, `[a,b)`, and `(a,b]` have distinct membership. For equal finite endpoints, only `[a,a]` has a member.

Operations in `Interval.Exact` are exact rational set operations:

- **Minkowski addition**: `[1,3] + [4,9] = [5,12]`. An endpoint is included in a sum only when both contributing endpoints are included.
- **Subtraction**: `[1,3] − [4,9] = [-8,-1]`, negating the second interval before addition.
- **Intersection**: retain common members. A coincident endpoint stays included only if both intervals include it.
- **Membership and normalization**: reversed finite endpoints and open singletons become empty; finite and unbounded endpoints are explicit.

The rational denominator is positive by construction (`OnePlus n` represents `n+1`). Equal rationals need not share a normalized stored numerator and denominator; comparisons use exact cross multiplication. Floating rounding, multiplication, and division are not yet implemented.

## Dependency remains visible

`x:[0,1]; x−x` yields `[-1,1]` in ordinary interval arithmetic. That is a safe but coarse enclosure produced after occurrence identity has been forgotten. It is not a claim that two random variables are independent.

If the compiler knows both occurrences denote the same expression, the exact result is `0`. Expression identity, affine arithmetic, symbolic constraints, or another correlation-aware refinement belongs in a richer layer; this library must not pretend naive interval propagation solves it.

## Similar-looking objects are not interchangeable

| Object | What it actually says |
|---|---|
| Exact interval | A specified subset of an ordered line |
| Exact nominal definition | A rational chosen by standard or convention; not a measurement of the manufactured object |
| Physical tolerance | Declared allowable departures from a nominal value |
| Instrument/measurement bound | Claimed enclosure conditional on source and calibration; not statistical sampling coverage |
| Frequentist confidence interval | A procedure with sampling and coverage assumptions, not merely two endpoints |
| Bayesian credible interval | A posterior probability statement conditional on model, likelihood, and prior |
| Bootstrap interval | Depends on resampling unit, design, estimator, method, and validity |
| Identification region | Values compatible with specified model and evidence |
| Covariance or correlated error | Dependence structure, not representable by independent one-dimensional bounds alone |
| Floating-point enclosure | A numerical enclosure that must use outward rounding |
| Ordered versus dual epsilon | A nilpotent tangent `ε²=0` is not an ordered positive endpoint displacement |

This table records distinctions, not implemented inference procedures. Statistical construction and empirical validation belong in statistical consumers such as Econometrician-in-a-Box unless a small reusable mathematical kernel later justifies extraction.

## Ownership

- `intervals.idr`: interval sets, exact endpoint arithmetic, membership, normalization, relations, and eventually proven enclosure operations.
- [Idriç](https://github.com/isomorphisms/Idric): public type semantics, elaboration, compiler checking, and target-neutral handoff.
- [Econometrician-in-a-Box](https://github.com/bl4ckb4ll/econometrician): sampling design, calibration, estimation, confidence procedures, identification, and statistical reporting.
- [Geofence](https://github.com/dilapidated-shed/geofence): may consume linear bounds, but longitude, bearing, and time-of-day wrap require circular arcs rather than fake linear `[start,end]` intervals.

## Constraints on the next pass

1. Make malformed spans unconstructible or proof-requiring instead of relying on callers to use the smart constructor.
2. Establish universal membership/enclosure laws for the local implementation, not only concrete `Refl` examples.
3. Lift intervals over ordered `Quantity dimension` values so units survive typing.
4. Add exact multiplication before deciding honest division semantics for intervals crossing zero.
5. Implement Float16 and Float32 only with actual directed rounding; neither may silently pass through host `Double`.
6. Treat higher-order uncertainty, unknown containment structures, source manipulation, and incomplete model knowledge as outside this module.
