module Diff where

import Data.Set

diffSet :: (Eq a,Ord a) 
	=> Set a		-- ^ Set 1
	-> Set a 		-- ^ Set 2
	-> (Set a,Set a,Set a)	-- ^ (Things in 1 but not in 2,Things in 2 but not in 1,Things in both sets)
diffSet set1 set2 = let
	int = intersection set1 set2
	in1 = difference set1 int
	in2 = difference set2 int in (in1,in2,int)

