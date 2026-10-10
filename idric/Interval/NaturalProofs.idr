module Interval.NaturalProofs

import Data.Nat
import Data.Nat.Order.Properties
import Data.So
import Syntax.PreorderReasoning

%default total

-- This module is the inherited Idris compatibility boundary for structural
-- natural-number order proofs. Maintained .idric modules import only the
-- semantic, snake-case surface below.
public export
NaturalOrder : Nat -> Nat -> Type
NaturalOrder = LTE

public export
truth_to_equality : So condition -> condition = True
truth_to_equality = soToEq

public export
equality_to_truth : condition = True -> So condition
equality_to_truth = eqToSo

public export
natural_order : Nat -> Nat -> Bool
natural_order = lte

public export
natural_order_from_true :
  (left, right : Nat) ->
  natural_order left right = True ->
  NaturalOrder left right
natural_order_from_true = lteIsLTE

public export
natural_order_to_true :
  (left, right : Nat) ->
  NaturalOrder left right ->
  natural_order left right = True
natural_order_to_true = LteIslte

public export
decide_natural_order :
  (left, right : Nat) ->
  Dec (NaturalOrder left right)
decide_natural_order = isLTE

public export
natural_order_reflexive : {value : Nat} -> NaturalOrder value value
natural_order_reflexive = reflexive

public export
natural_order_antisymmetric :
  {left, right : Nat} ->
  NaturalOrder left right ->
  NaturalOrder right left ->
  left = right
natural_order_antisymmetric {left} {right} left_to_right right_to_left =
  antisymmetric left_to_right right_to_left

-- (a+b)+(c+d) = (a+c)+(b+d).
public export
natural_plus_shuffle :
  (first, second, third, fourth : Nat) ->
  (first + second) + (third + fourth) =
  (first + third) + (second + fourth)
natural_plus_shuffle first second third fourth = Calc $
  |~ (first + second) + (third + fourth)
  ~~ first + (second + (third + fourth))
       ...(sym (plusAssociative first second (third + fourth)))
  ~~ first + ((second + third) + fourth)
       ...(cong (first +) (plusAssociative second third fourth))
  ~~ first + ((third + second) + fourth)
       ...(cong (first +) (cong (+ fourth) (plusCommutative second third)))
  ~~ first + (third + (second + fourth))
       ...(cong (first +) (sym (plusAssociative third second fourth)))
  ~~ (first + third) + (second + fourth)
       ...(plusAssociative first third (second + fourth))

-- If a-d <= c-b and e-h <= g-f, then (a+e)-(d+h) <= (c+g)-(b+f).
public export
cross_sum_add_order :
  {a, b, c, d, e, f, g, h : Nat} ->
  NaturalOrder (a + d) (c + b) ->
  NaturalOrder (e + h) (g + f) ->
  NaturalOrder ((a + e) + (d + h)) ((c + g) + (b + f))
cross_sum_add_order
  {a} {b} {c} {d} {e} {f} {g} {h}
  first_order
  second_order =
    rewrite natural_plus_shuffle a e d h in
    rewrite sym (natural_plus_shuffle c b g f) in
    plusLteMonotone first_order second_order

-- Negating both formal differences reverses their order.
public export
cross_sum_negate_order :
  {a, b, c, d : Nat} ->
  NaturalOrder (a + d) (c + b) ->
  NaturalOrder (d + a) (b + c)
cross_sum_negate_order {a} {b} {c} {d} ordered =
  rewrite plusCommutative d a in
  rewrite plusCommutative b c in
  ordered

-- Multiplication by a natural factor preserves order.
public export
cross_sum_scale_order :
  (factor : Nat) ->
  {a, b, c, d : Nat} ->
  NaturalOrder (a + d) (c + b) ->
  NaturalOrder
    ((factor * a) + (factor * d))
    ((factor * c) + (factor * b))
cross_sum_scale_order factor {a} {b} {c} {d} ordered =
  rewrite sym (multDistributesOverPlusRight factor a d) in
  rewrite sym (multDistributesOverPlusRight factor c b) in
  multLteMonotoneRight factor (a + d) (c + b) ordered

-- Addition respects cross-sum semantic equality.
public export
cross_sum_add_equivalent :
  {a, b, c, d, e, f, g, h : Nat} ->
  a + d = c + b ->
  e + h = g + f ->
  (a + e) + (d + h) = (c + g) + (b + f)
cross_sum_add_equivalent
  {a} {b} {c} {d} {e} {f} {g} {h}
  first_equal
  second_equal = Calc $
    |~ (a + e) + (d + h)
    ~~ (a + d) + (e + h) ...(natural_plus_shuffle a e d h)
    ~~ (c + b) + (g + f) ...(cong2 (+) first_equal second_equal)
    ~~ (c + g) + (b + f) ...(natural_plus_shuffle c b g f)
