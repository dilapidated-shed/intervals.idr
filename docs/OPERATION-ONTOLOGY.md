# What operations on intervals mean

`intervals.idr` should not inherit the ordinary numeric progression

```text
addition → multiplication → division → powers → transcendental functions
```

as though every operation were automatically fundamental merely because the endpoint scalar supports it.

An interval is first a region specified by ordered boundaries and endpoint membership. Operations on intervals should be justified by a map, action, relation, or universal construction whose meaning is stated explicitly.

## Structural core

These belong near the center of the package:

- construction from validated boundaries;
- empty/nonempty distinction;
- executable and proposition-level membership;
- open/closed/unbounded boundary data;
- intersection as common restriction;
- typed relations such as separation, touching, overlap, containment, and equality;
- image and inverse-image interfaces when a map supplies enough structure to compute them exactly.

The current constructor name `points_between` is implementation vocabulary, not a claim that every continuum is ontologically a completed set of individual points. The present implementation has **exact rational values with decidable order**. A synthetic, intuitionistic, locale-theoretic, infinitesimal, or otherwise non-point-set continuum would require a different carrier and different evidence. It should not be smuggled into or ruled out by this exact-rational module.

A future naming cleanup should prefer neutral vocabulary such as `nonempty_span` or `validated_region` over language suggesting that the package has settled the ontology of continua.

## Addition and subtraction

Interval addition is the direct image of the cartesian product under the chosen binary map

```text
add : Scalar × Scalar → Scalar.
```

For ordered additive scalars this gives the Minkowski sum. Negation is an order-reversing unary map; subtraction is addition after negation.

These operations are useful because many concrete questions really are about displacement, accumulated error, tolerance addition, or translating a region. Their proofs should still state the hypotheses under which endpoint arithmetic computes the exact image.

## Multiplication is derived, not privileged

Pointwise interval multiplication is the image under

```text
multiply : Scalar × Scalar → Scalar.
```

It can be useful, and the repository now contains an exact implementation. But its existence does **not** make it the next conceptual layer after addition, nor does it make intervals into a preferred semiring abstraction.

Treat multiplication as an optional derived module. Its purpose is to support a caller that genuinely asks for the range of scalar products. Matrix multiplication, composition of linear maps, tensor product, convolution, and scalar action are different constructions and must not be reduced to this operation by naming alone.

The same warning applies to reciprocal and division. Their set-valued implementation answers a specific range question; it does not establish division as part of the minimal ontology of an interval.

## Basis, frame, and linear action

A more natural geometric extension often begins with coefficients relative to a basis or frame:

```text
coefficient regions + basis → patch / parallelotope / zonotope / other image.
```

A matrix or general linear transformation then acts on the represented region. That is a map between geometric objects, not “interval multiplication.”

Questions to preserve explicitly:

- Which space does the object live in?
- Which basis or frame expresses its coordinates?
- Is a change of basis passive, or is a linear transformation acting actively?
- Is the representation a cartesian box, parallelotope, zonotope, ellipsoid, Gaussian, or another patch?
- Which information is invariant when the basis changes?
- Is the result exact, an enclosure, or an approximation?

Intervals can supply one-dimensional coefficient regions, but the basis-bearing object should own the higher-dimensional meaning.

## Tensor products and other products

The word “product” is overloaded. At minimum keep separate:

- cartesian product of regions;
- scalar pointwise product and its image;
- tensor product of spaces, sections, or coefficient-bearing objects;
- composition of maps;
- matrix multiplication as composition/contraction;
- convolution of kernels;
- fibre product / pullback;
- direct product, direct sum, and coproduct;
- intersection / meet in an order of regions.

No generic `multiply` interface should erase these distinctions merely to make syntax compact.

## Crisp intervals and smooth patches

A closed or open interval gives a crisp in/out membership predicate. A Gaussian-shaped patch is not just a softer interval and should not be forced into endpoint arithmetic.

A smooth patch may need data such as:

```text
center
basis or frame
covariance / precision / quadratic form
amplitude or normalization convention
support convention, if any
map under which it is transported
provenance and empirical meaning, when statistical
```

Possible relations between crisp intervals and smooth patches include thresholding, enclosure, support approximation, level sets, pullback/pushforward, convolution, and limits. None is definitionally the same as the others.

The next design conversation should therefore compare **region + basis + profile** constructions rather than automatically adding more scalar arithmetic.

## Category-theoretic discipline

Category theory is useful here when it forces the operation to reveal its domain, codomain, variance, and composition law.

Before adding an interval operation, ask:

1. What objects and morphisms are involved?
2. Is this an image, inverse image, action, tensor, product, pullback, quotient, convolution, or composition?
3. What hypotheses make the result remain representable by one interval?
4. What information is lost by lowering the result to endpoint data?
5. Is the operation natural under change of coordinates or basis?
6. Is the code proving an exact equality, a sound enclosure, or merely computing examples?

This is preferable to constructing an arithmetic tower because the scalar type happens to expose operators.

## Separate uncertainty research

The general structure involving many kinds of ε, unknown resolution conditions, unknown nesting depth, interactions among ε-regions, unknown unknowns, and strategic distortion through propaganda or marketing does not belong in this package.

That broader work belongs in Econometrician-in-a-Box. `intervals.idr` may later provide one small reusable region type to it, but must not become the ontology of uncertainty.

## Proof and acceptance boundary

The `.idric` implementation has been compiled by the pinned Idriç compiler and its fixtures executed. That is genuine source-language acceptance: the maintained source uses Idriç-only `choice` declarations and notation.

A separate issue remains: several universal theorems currently live over proof-oriented `SignedDifference` and `OrderedRational` models rather than directly over production `ExactRational`. Those models are legitimate proof scaffolds, but they do not by themselves prove that production operations satisfy the same laws.

The immediate proof priority is therefore a checked bridge between the proof model and `ExactRational`, followed by production-level enclosure theorems. “Green” must not mean weakening the claim until a test passes.