module Interval.Exact

%default total

-- Exact ordered scalar.  A denominator is positive BY CONSTRUCTION.
-- No binary-float conversion or unproved rounding occurs in this module.
public export
data PositiveDenominator = OnePlus Nat

public export
denominatorValue : PositiveDenominator -> Integer
denominatorValue (OnePlus n) = cast (S n)

public export
multiplyDenominators : PositiveDenominator -> PositiveDenominator -> PositiveDenominator
multiplyDenominators (OnePlus a) (OnePlus b) = OnePlus (a + b + a * b)

public export
data Rat = Ratio Integer PositiveDenominator

public export
whole : Integer -> Rat
whole numerator = Ratio numerator (OnePlus 0)

-- 'over 1 (OnePlus 3)' denotes 1/4. The successor avoids zero denominators.
public export
over : Integer -> PositiveDenominator -> Rat
over = Ratio

public export
ratAdd : Rat -> Rat -> Rat
ratAdd (Ratio a b) (Ratio c d) =
  Ratio (a * denominatorValue d + c * denominatorValue b)
        (multiplyDenominators b d)

public export
ratNegate : Rat -> Rat
ratNegate (Ratio a b) = Ratio (-a) b

public export
ratSubtract : Rat -> Rat -> Rat
ratSubtract a b = ratAdd a (ratNegate b)

public export
ratEqual : Rat -> Rat -> Bool
ratEqual (Ratio a b) (Ratio c d) =
  a * denominatorValue d == c * denominatorValue b

public export
ratLess : Rat -> Rat -> Bool
ratLess (Ratio a b) (Ratio c d) =
  a * denominatorValue d < c * denominatorValue b

public export
ratLessOrEqual : Rat -> Rat -> Bool
ratLessOrEqual x y = ratLess x y || ratEqual x y

-- Endpoint inclusion is data, not a nilpotent epsilon.
public export
data Inclusion = Included | Excluded

public export
isIncluded : Inclusion -> Bool
isIncluded Included = True
isIncluded Excluded = False

public export
bothIncluded : Inclusion -> Inclusion -> Inclusion
bothIncluded Included Included = Included
bothIncluded _ _ = Excluded

public export
data LowerBound
  = NegativeInfinity
  | LowerAt Rat Inclusion

public export
data UpperBound
  = UpperAt Rat Inclusion
  | PositiveInfinity

-- Construct ordinary intervals via 'interval' or the convenience functions.
-- For this initial compatibility kernel constructors are visible. Users of the
-- public API should not construct PointsBetween directly: that would bypass
-- validation of reversed/open-singleton bounds. Proof-carrying constructors
-- remain a separate elaboration question for the Idriç integration.
public export
data Interval
  = NoPoints
  | PointsBetween LowerBound UpperBound

public export
interval : LowerBound -> UpperBound -> Interval
interval (LowerAt lo loIn) (UpperAt hi hiIn) =
  if ratLess hi lo
    then NoPoints
    else if ratEqual lo hi && not (isIncluded loIn && isIncluded hiIn)
      then NoPoints
      else PointsBetween (LowerAt lo loIn) (UpperAt hi hiIn)
interval lo hi = PointsBetween lo hi

public export
closed : Rat -> Rat -> Interval
closed lo hi = interval (LowerAt lo Included) (UpperAt hi Included)

public export
openInterval : Rat -> Rat -> Interval
openInterval lo hi = interval (LowerAt lo Excluded) (UpperAt hi Excluded)

public export
leftOpen : Rat -> Rat -> Interval
leftOpen lo hi = interval (LowerAt lo Excluded) (UpperAt hi Included)

public export
rightOpen : Rat -> Rat -> Interval
rightOpen lo hi = interval (LowerAt lo Included) (UpperAt hi Excluded)

public export
allNumbers : Interval
allNumbers = interval NegativeInfinity PositiveInfinity

public export
below : Rat -> Inclusion -> Interval
below upper inclusion = interval NegativeInfinity (UpperAt upper inclusion)

public export
above : Rat -> Inclusion -> Interval
above lower inclusion = interval (LowerAt lower inclusion) PositiveInfinity

public export
openLeft : Interval -> Interval
openLeft NoPoints = NoPoints
openLeft (PointsBetween NegativeInfinity hi) = PointsBetween NegativeInfinity hi
openLeft (PointsBetween (LowerAt lo _) hi) =
  interval (LowerAt lo Excluded) hi

public export
openRight : Interval -> Interval
openRight NoPoints = NoPoints
openRight (PointsBetween lo PositiveInfinity) = PointsBetween lo PositiveInfinity
openRight (PointsBetween lo (UpperAt hi _)) =
  interval lo (UpperAt hi Excluded)

public export
allowsLower : LowerBound -> Rat -> Bool
allowsLower NegativeInfinity _ = True
allowsLower (LowerAt lo Included) x = ratLessOrEqual lo x
allowsLower (LowerAt lo Excluded) x = ratLess lo x

public export
allowsUpper : UpperBound -> Rat -> Bool
allowsUpper PositiveInfinity _ = True
allowsUpper (UpperAt hi Included) x = ratLessOrEqual x hi
allowsUpper (UpperAt hi Excluded) x = ratLess x hi

public export
contains : Interval -> Rat -> Bool
contains NoPoints _ = False
contains (PointsBetween lo hi) x =
  allowsLower lo x && allowsUpper hi x

public export
sameInclusion : Inclusion -> Inclusion -> Bool
sameInclusion Included Included = True
sameInclusion Excluded Excluded = True
sameInclusion _ _ = False

public export
sameLower : LowerBound -> LowerBound -> Bool
sameLower NegativeInfinity NegativeInfinity = True
sameLower (LowerAt x i) (LowerAt y j) =
  ratEqual x y && sameInclusion i j
sameLower _ _ = False

public export
sameUpper : UpperBound -> UpperBound -> Bool
sameUpper PositiveInfinity PositiveInfinity = True
sameUpper (UpperAt x i) (UpperAt y j) =
  ratEqual x y && sameInclusion i j
sameUpper _ _ = False

public export
intervalEqual : Interval -> Interval -> Bool
intervalEqual NoPoints NoPoints = True
intervalEqual (PointsBetween lo hi) (PointsBetween lo2 hi2) =
  sameLower lo lo2 && sameUpper hi hi2
intervalEqual _ _ = False

-- Set-valued/Minkowski addition. No probabilistic independence is assumed.
public export
addLower : LowerBound -> LowerBound -> LowerBound
addLower NegativeInfinity _ = NegativeInfinity
addLower _ NegativeInfinity = NegativeInfinity
addLower (LowerAt a i) (LowerAt b j) =
  LowerAt (ratAdd a b) (bothIncluded i j)

public export
addUpper : UpperBound -> UpperBound -> UpperBound
addUpper PositiveInfinity _ = PositiveInfinity
addUpper _ PositiveInfinity = PositiveInfinity
addUpper (UpperAt a i) (UpperAt b j) =
  UpperAt (ratAdd a b) (bothIncluded i j)

public export
addInterval : Interval -> Interval -> Interval
addInterval NoPoints _ = NoPoints
addInterval _ NoPoints = NoPoints
addInterval (PointsBetween a b) (PointsBetween c d) =
  interval (addLower a c) (addUpper b d)

public export
lowerOfNegatedUpper : UpperBound -> LowerBound
lowerOfNegatedUpper PositiveInfinity = NegativeInfinity
lowerOfNegatedUpper (UpperAt x i) = LowerAt (ratNegate x) i

public export
upperOfNegatedLower : LowerBound -> UpperBound
upperOfNegatedLower NegativeInfinity = PositiveInfinity
upperOfNegatedLower (LowerAt x i) = UpperAt (ratNegate x) i

public export
negateInterval : Interval -> Interval
negateInterval NoPoints = NoPoints
negateInterval (PointsBetween lo hi) =
  interval (lowerOfNegatedUpper hi) (upperOfNegatedLower lo)

-- Ordinary interval subtraction loses repeated-expression correlation.
-- x:[0,1] and x-x evaluates to [-1,1] HERE, not the symbolic singleton 0.
public export
subtractInterval : Interval -> Interval -> Interval
subtractInterval a b = addInterval a (negateInterval b)

-- Intersection of sets, including coincident open/closed endpoints.
-- This is restriction by known bounds, NOT statistical conditioning.
public export
strongerLower : LowerBound -> LowerBound -> LowerBound
strongerLower NegativeInfinity b = b
strongerLower a NegativeInfinity = a
strongerLower (LowerAt a ai) (LowerAt b bi) =
  if ratLess a b
     then LowerAt b bi
     else if ratLess b a
       then LowerAt a ai
       else LowerAt a (bothIncluded ai bi)

public export
strongerUpper : UpperBound -> UpperBound -> UpperBound
strongerUpper PositiveInfinity b = b
strongerUpper a PositiveInfinity = a
strongerUpper (UpperAt a ai) (UpperAt b bi) =
  if ratLess a b
     then UpperAt a ai
     else if ratLess b a
       then UpperAt b bi
       else UpperAt a (bothIncluded ai bi)

public export
intersectInterval : Interval -> Interval -> Interval
intersectInterval NoPoints _ = NoPoints
intersectInterval _ NoPoints = NoPoints
intersectInterval (PointsBetween lo hi) (PointsBetween lo2 hi2) =
  interval (strongerLower lo lo2) (strongerUpper hi hi2)
