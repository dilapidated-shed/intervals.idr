module Interval.Tests

import Interval.Exact

%default total

-- Every equality ending in Refl must be checked by Idris, not merely printed.
plus_closed :
  intervalEqual
    (addInterval (closed (whole 1) (whole 3))
                 (closed (whole 4) (whole 9)))
    (closed (whole 5) (whole 12)) = True
plus_closed = Refl

plus_open :
  intervalEqual
    (addInterval (rightOpen (whole 1) (whole 3))
                 (leftOpen (whole 4) (whole 9)))
    (openInterval (whole 5) (whole 12)) = True
plus_open = Refl

subtract_extremes :
  intervalEqual
    (subtractInterval (closed (whole 1) (whole 3))
                      (closed (whole 4) (whole 9)))
    (closed (whole (-8)) (whole (-1))) = True
subtract_extremes = Refl

-- Explicit record of the dependency problem, not a false proof of x-x=0.
dependency_is_lost :
  intervalEqual
    (subtractInterval (closed (whole 0) (whole 1))
                      (closed (whole 0) (whole 1)))
    (closed (whole (-1)) (whole 1)) = True
dependency_is_lost = Refl

empty_open_singleton :
  intervalEqual (openInterval (whole 1) (whole 1)) NoPoints = True
empty_open_singleton = Refl

empty_inverted :
  intervalEqual (closed (whole 3) (whole 1)) NoPoints = True
empty_inverted = Refl

open_lower_not_member :
  contains (leftOpen (whole 1) (whole 3)) (whole 1) = False
open_lower_not_member = Refl

closed_lower_member :
  contains (closed (whole 1) (whole 3)) (whole 1) = True
closed_lower_member = Refl

open_right_not_member :
  contains (rightOpen (whole 1) (whole 3)) (whole 3) = False
open_right_not_member = Refl

unbounded_contains_negative :
  contains (below (whole 4) Excluded) (whole (-100)) = True
unbounded_contains_negative = Refl

unbounded_excludes_endpoint :
  contains (below (whole 4) Excluded) (whole 4) = False
unbounded_excludes_endpoint = Refl

empty_absorbs_addition :
  intervalEqual (addInterval NoPoints Interval.Exact.allNumbers) NoPoints = True
empty_absorbs_addition = Refl

opposite_infinite_rays_sum_all :
  intervalEqual (addInterval (above (whole 0) Included)
                              (below (whole 0) Included))
                Interval.Exact.allNumbers = True
opposite_infinite_rays_sum_all = Refl

intersection_open_boundary_empty :
  intervalEqual (intersectInterval (closed (whole 0) (whole 1))
                                   (leftOpen (whole 1) (whole 2)))
                NoPoints = True
intersection_open_boundary_empty = Refl

intersection_singleton :
  intervalEqual (intersectInterval (closed (whole 0) (whole 1))
                                   (closed (whole 1) (whole 2)))
                (closed (whole 1) (whole 1)) = True
intersection_singleton = Refl

exact_quarters :
  ratEqual (ratAdd (over 1 (OnePlus 3)) (over 1 (OnePlus 3)))
           (over 1 (OnePlus 1)) = True
exact_quarters = Refl

main : IO ()
main = putStrLn "intervals.idr: checked exact interval fixtures"
