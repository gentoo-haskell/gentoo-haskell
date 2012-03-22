-- QC tests for random number generators
--
-- Require QuickCheck >= 2.2
module QC (
  tests
  ) where

import Control.Applicative

import Data.Word (Word8,Word16,Word32,Word64,Word)
import Data.Int  (Int8, Int16, Int32, Int64 )

import Test.QuickCheck
import Test.QuickCheck.Monadic
import Test.Framework
import Test.Framework.Providers.QuickCheck2

import System.Random.MWC



----------------------------------------------------------------

tests :: GenIO -> Test
tests g = testGroup "Range"
  [ testProperty "Int8"   $ (prop_InRange g :: InRange Int8)
  , testProperty "Int16"  $ (prop_InRange g :: InRange Int16)
  , testProperty "Int32"  $ (prop_InRange g :: InRange Int32)
  , testProperty "Int64"  $ (prop_InRange g :: InRange Int64)
  , testProperty "Word8"  $ (prop_InRange g :: InRange Word8)
  , testProperty "Word16" $ (prop_InRange g :: InRange Word16)
  , testProperty "Word32" $ (prop_InRange g :: InRange Word32)
  , testProperty "Word64" $ (prop_InRange g :: InRange Word64)
  , testProperty "Int"    $ (prop_InRange g :: InRange Int)
  , testProperty "Word64" $ (prop_InRange g :: InRange Word)
  , testProperty "Float"  $ (prop_InRange g :: InRange Float)
  , testProperty "Double" $ (prop_InRange g :: InRange Double)
  ]



----------------------------------------------------------------

-- Test that values generated with uniformR never lie outside range.
prop_InRange :: (Variate a, Ord a,Num a) => GenIO -> OrderedPair a -> Property
prop_InRange g (OrderedPair (x1,x2)) = monadicIO $ do
  r <- run $ uniformR (x1,x2) g
  assert (x1 <= r && r <= x2)

type InRange a = OrderedPair a -> Property

-- Ordered pair (x,y) for which x <= y
newtype OrderedPair a = OrderedPair (a,a)
                        deriving Show
instance (Ord a, Arbitrary a) => Arbitrary (OrderedPair a) where
  arbitrary = OrderedPair <$> suchThat arbitrary (uncurry (<=))
