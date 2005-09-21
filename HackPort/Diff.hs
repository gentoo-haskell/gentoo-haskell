module Diff where

import Prelude hiding(map)
import qualified Data.List as List
import Data.Set

data DiffAction
	= Add
	| Remove
	| Stay
	deriving (Eq,Ord,Show)

data DiffResult a
	= DiffResult DiffAction a
	deriving (Eq)

instance Ord x => Ord (DiffResult x) where
	compare (DiffResult _ x1) (DiffResult _ x2) = compare x1 x2

instance Show a => Show (DiffResult a) where
	show (DiffResult action x) = (case action of
		Add -> '+'
		Remove -> '-'
		Stay -> '='):(show x)

{-class Diff a b where
	diff :: a -> a -> DiffResult b

instance Diff [a] a where
	diff lst1 lst2 = -}

diffSet :: (Eq a,Ord a) => Set a -> Set a -> Set (DiffResult a)
diffSet set1 set2 = unions [map (DiffResult Add) adds,map (DiffResult Remove) removes,map (DiffResult Stay) stays] where
	stays = intersection set1 set2
	removes = difference set1 stays
	adds = difference set2 stays

showDiff :: Show a => Set (DiffResult a) -> String
showDiff diffs = unlines (List.map show (elems diffs))
