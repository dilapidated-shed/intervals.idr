module Interval.Evidence

import Interval.Exact

%default total

-- A provenance tree deliberately retains BOTH inputs. It is not a generic
-- confidence score and is not a substitute for empirical calibration.
public export
data SourceKind
  = Observation
  | Definition
  | Assumption
  | StatisticalMethod

public export
data Provenance
  = From SourceKind String
  | Derived String Provenance Provenance

public export
data MissingReason
  = MissingMeasurement
  | CalibrationNotEstablished
  | SamplingDesignUnstated
  | ModelNotIdentified
  | NumericalEnclosureNotEstablished
  | OtherReason String

public export
data BoundsMeaning
  = FeasibleSet
  | ToleranceBound
  | MeasurementBound
  | ModelConditionalBound
  | DerivedEnclosure

-- NoBounds is NOT [0,0], the empty set, an unbounded interval, or a prior.
-- These have different meanings. A provenance tree survives through arithmetic.
public export
data BoundsKnowledge
  = NoBounds (List MissingReason) Provenance
  | HasBounds BoundsMeaning Interval Provenance

public export
sourceOf : BoundsKnowledge -> Provenance
sourceOf (NoBounds _ source) = source
sourceOf (HasBounds _ _ source) = source

public export
unresolved : BoundsKnowledge -> Bool
unresolved (NoBounds _ _) = True
unresolved (HasBounds _ _ _) = False

public export
reasonsOf : BoundsKnowledge -> List MissingReason
reasonsOf (NoBounds reasons _) = reasons
reasonsOf (HasBounds _ _ _) = []

public export
addKnowledge : BoundsKnowledge -> BoundsKnowledge -> BoundsKnowledge
addKnowledge (NoBounds leftReasons leftSource) (NoBounds rightReasons rightSource) =
  NoBounds (leftReasons ++ rightReasons)
           (Derived "interval addition unavailable" leftSource rightSource)
addKnowledge (NoBounds reasons leftSource) right =
  NoBounds reasons
           (Derived "interval addition unavailable" leftSource (sourceOf right))
addKnowledge left (NoBounds reasons rightSource) =
  NoBounds reasons
           (Derived "interval addition unavailable" (sourceOf left) rightSource)
addKnowledge (HasBounds _ left leftSource) (HasBounds _ right rightSource) =
  HasBounds DerivedEnclosure (addInterval left right)
            (Derived "Minkowski addition" leftSource rightSource)

-- Provenance is inspectable; copying the result never implicitly supplies an
-- independence assumption or upgrades a model-derived bound to a measurement.
public export
mentionsSource : String -> Provenance -> Bool
mentionsSource wanted (From _ source) = wanted == source
mentionsSource wanted (Derived _ left right) =
  mentionsSource wanted left || mentionsSource wanted right
