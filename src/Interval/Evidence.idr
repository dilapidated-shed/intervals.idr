module Interval.Evidence

import Interval.Exact

%default total

public export
data BoundsMeaning
  = FeasibleSet
  | ToleranceBound
  | MeasurementBound
  | ModelConditionalBound
  | DerivedEnclosure

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
  | Classified BoundsMeaning Provenance
  | Derived String Provenance Provenance

public export
data MissingReason
  = MissingMeasurement
  | CalibrationNotEstablished
  | SamplingDesignUnstated
  | ModelNotIdentified
  | NumericalEnclosureNotEstablished
  | OtherReason String

-- NoBounds is NOT [0,0], the empty set, an unbounded interval, or a prior.
-- These have different meanings. A provenance tree survives through arithmetic.
public export
data BoundsKnowledge
  = NoBounds (List MissingReason) Provenance
  | HasBounds BoundsMeaning Interval Provenance

public export
sourceOf : BoundsKnowledge -> Provenance
sourceOf (NoBounds _ source) = source
sourceOf (HasBounds meaning _ source) = Classified meaning source

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
addKnowledge (HasBounds leftMeaning left leftSource) (HasBounds rightMeaning right rightSource) =
  HasBounds DerivedEnclosure (addInterval left right)
            (Derived "Minkowski addition"
              (Classified leftMeaning leftSource)
              (Classified rightMeaning rightSource))

-- Provenance is inspectable; copying the result never implicitly supplies an
-- independence assumption or upgrades a model-derived bound to a measurement.
public export
mentionsSource : String -> Provenance -> Bool
mentionsSource wanted (From _ source) = wanted == source
mentionsSource wanted (Classified _ source) = mentionsSource wanted source
mentionsSource wanted (Derived _ left right) =
  mentionsSource wanted left || mentionsSource wanted right

-- Bound purposes survive arithmetic inside the derivation tree.  In particular
-- a model-conditional bound cannot silently become measured evidence.
public export
sameMeaning : BoundsMeaning -> BoundsMeaning -> Bool
sameMeaning FeasibleSet FeasibleSet = True
sameMeaning ToleranceBound ToleranceBound = True
sameMeaning MeasurementBound MeasurementBound = True
sameMeaning ModelConditionalBound ModelConditionalBound = True
sameMeaning DerivedEnclosure DerivedEnclosure = True
sameMeaning _ _ = False

public export
mentionsMeaning : BoundsMeaning -> Provenance -> Bool
mentionsMeaning _ (From _ _) = False
mentionsMeaning expected (Classified actual source) =
  sameMeaning expected actual || mentionsMeaning expected source
mentionsMeaning expected (Derived _ left right) =
  mentionsMeaning expected left || mentionsMeaning expected right
