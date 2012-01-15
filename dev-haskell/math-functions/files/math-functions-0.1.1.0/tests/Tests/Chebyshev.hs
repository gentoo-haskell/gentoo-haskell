module Tests.Chebyshev (
  tests
  ) where

import Data.Vector.Unboxed                  (fromList)
import Test.Framework
import Test.Framework.Providers.QuickCheck2
import Test.QuickCheck                      (Arbitrary(..))

import Tests.Helpers
import Numeric.Polynomial.Chebyshev


tests :: Test
tests = testGroup "Chebyshev polynomials"
  [ testProperty "Chebyshev 0" $ \a0 (Ch x) ->
      (ch0 x * a0) ≈ (chebyshev x $ fromList [a0])
  , testProperty "Chebyshev 1" $ \a0 a1 (Ch x) ->
      (a0*ch0 x + a1*ch1 x) ≈  (chebyshev x $ fromList [a0,a1])
  , testProperty "Chebyshev 2" $ \a0 a1 a2 (Ch x) ->
       (a0*ch0 x + a1*ch1 x + a2*ch2 x) ≈ (chebyshev x $ fromList [a0,a1,a2])
  , testProperty "Chebyshev 3" $ \a0 a1 a2 a3 (Ch x) ->
       (a0*ch0 x + a1*ch1 x + a2*ch2 x + a3*ch3 x) ≈ (chebyshev x $ fromList [a0,a1,a2,a3])
  , testProperty "Chebyshev 4" $ \a0 a1 a2 a3 a4 (Ch x) ->
       (a0*ch0 x + a1*ch1 x + a2*ch2 x + a3*ch3 x + a4*ch4 x) ≈ (chebyshev x $ fromList [a0,a1,a2,a3,a4])
  ]
  where (≈) = eq 1e-12


-- Chebyshev polynomials of low order
ch0,ch1,ch2,ch3,ch4 :: Double -> Double
ch0 _ = 1
ch1 x = x
ch2 x = 2*x^2 - 1
ch3 x = 4*x^3 - 3*x
ch4 x = 8*x^4 - 8*x^2 + 1


-- Double in the [-1 .. 1] range
newtype Ch = Ch Double
             deriving Show
instance Arbitrary Ch  where
  arbitrary = do x <- arbitrary
                 return $ Ch $ 2 * (snd . properFraction) x - 1
