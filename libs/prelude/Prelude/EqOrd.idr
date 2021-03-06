module Prelude.EqOrd

import Builtin
import Prelude.Basics
import Prelude.Ops

%default total

------------------------
-- EQUALITY, ORDERING --
------------------------

||| The Eq interface defines inequality and equality.
public export
interface Eq ty where
  (==) : ty -> ty -> Bool
  (/=) : ty -> ty -> Bool

  x == y = not (x /= y)
  x /= y = not (x == y)

public export
Eq () where
  _ == _ = True

public export
Eq Bool where
  True == True = True
  False == False = True
  _ == _ = False

public export
Eq Int where
  x == y = intToBool (prim__eq_Int x y)

public export
Eq Integer where
  x == y = intToBool (prim__eq_Integer x y)

public export
Eq Bits8 where
  x == y = intToBool (prim__eq_Bits8 x y)

public export
Eq Bits16 where
  x == y = intToBool (prim__eq_Bits16 x y)

public export
Eq Bits32 where
  x == y = intToBool (prim__eq_Bits32 x y)

public export
Eq Bits64 where
  x == y = intToBool (prim__eq_Bits64 x y)

public export
Eq Double where
  x == y = intToBool (prim__eq_Double x y)

public export
Eq Char where
  x == y = intToBool (prim__eq_Char x y)

public export
Eq String where
  x == y = intToBool (prim__eq_String x y)

public export
Eq a => Eq b => Eq (a, b) where
  (x1, y1) == (x2, y2) = x1 == x2 && y1 == y2

public export
data Ordering = LT | EQ | GT

public export
Eq Ordering where
  LT == LT = True
  EQ == EQ = True
  GT == GT = True
  _  == _  = False

||| The Ord interface defines comparison operations on ordered data types.
public export
interface Eq ty => Ord ty where
  compare : ty -> ty -> Ordering

  (<) : ty -> ty -> Bool
  (<) x y = compare x y == LT

  (>) : ty -> ty -> Bool
  (>) x y = compare x y == GT

  (<=) : ty -> ty -> Bool
  (<=) x y = compare x y /= GT

  (>=) : ty -> ty -> Bool
  (>=) x y = compare x y /= LT

  max : ty -> ty -> ty
  max x y = if x > y then x else y

  min : ty -> ty -> ty
  min x y = if (x < y) then x else y

public export
Ord () where
  compare _ _ = EQ

public export
Ord Bool where
  compare False False = EQ
  compare False True = LT
  compare True False = GT
  compare True True = EQ

public export
Ord Int where
  compare x y = if x < y then LT else if x == y then EQ else GT

  (<) x y = intToBool (prim__lt_Int x y)
  (<=) x y = intToBool (prim__lte_Int x y)
  (>) x y = intToBool (prim__gt_Int x y)
  (>=) x y = intToBool (prim__gte_Int x y)

public export
Ord Integer where
  compare x y = if x < y then LT else if x == y then EQ else GT

  (<) x y = intToBool (prim__lt_Integer x y)
  (<=) x y = intToBool (prim__lte_Integer x y)
  (>) x y = intToBool (prim__gt_Integer x y)
  (>=) x y = intToBool (prim__gte_Integer x y)

public export
Ord Bits8 where
  compare x y = if x < y then LT else if x == y then EQ else GT

  (<) x y = intToBool (prim__lt_Bits8 x y)
  (<=) x y = intToBool (prim__lte_Bits8 x y)
  (>) x y = intToBool (prim__gt_Bits8 x y)
  (>=) x y = intToBool (prim__gte_Bits8 x y)

public export
Ord Bits16 where
  compare x y = if x < y then LT else if x == y then EQ else GT

  (<) x y = intToBool (prim__lt_Bits16 x y)
  (<=) x y = intToBool (prim__lte_Bits16 x y)
  (>) x y = intToBool (prim__gt_Bits16 x y)
  (>=) x y = intToBool (prim__gte_Bits16 x y)

public export
Ord Bits32 where
  compare x y = if x < y then LT else if x == y then EQ else GT

  (<) x y = intToBool (prim__lt_Bits32 x y)
  (<=) x y = intToBool (prim__lte_Bits32 x y)
  (>) x y = intToBool (prim__gt_Bits32 x y)
  (>=) x y = intToBool (prim__gte_Bits32 x y)

public export
Ord Bits64 where
  compare x y = if x < y then LT else if x == y then EQ else GT

  (<) x y = intToBool (prim__lt_Bits64 x y)
  (<=) x y = intToBool (prim__lte_Bits64 x y)
  (>) x y = intToBool (prim__gt_Bits64 x y)
  (>=) x y = intToBool (prim__gte_Bits64 x y)

public export
Ord Double where
  compare x y = if x < y then LT else if x == y then EQ else GT

  (<) x y = intToBool (prim__lt_Double x y)
  (<=) x y = intToBool (prim__lte_Double x y)
  (>) x y = intToBool (prim__gt_Double x y)
  (>=) x y = intToBool (prim__gte_Double x y)

public export
Ord String where
  compare x y = if x < y then LT else if x == y then EQ else GT

  (<) x y = intToBool (prim__lt_String x y)
  (<=) x y = intToBool (prim__lte_String x y)
  (>) x y = intToBool (prim__gt_String x y)
  (>=) x y = intToBool (prim__gte_String x y)

public export
Ord Char where
  compare x y = if x < y then LT else if x == y then EQ else GT

  (<) x y = intToBool (prim__lt_Char x y)
  (<=) x y = intToBool (prim__lte_Char x y)
  (>) x y = intToBool (prim__gt_Char x y)
  (>=) x y = intToBool (prim__gte_Char x y)

public export
Ord a => Ord b => Ord (a, b) where
  compare (x1, y1) (x2, y2)
      = if x1 /= x2 then compare x1 x2
                    else compare y1 y2


