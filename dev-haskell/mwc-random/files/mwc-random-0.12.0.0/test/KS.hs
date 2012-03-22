-- Kolmogorov-Smirnov tests for distribution
--
-- Note that it's not most powerful test for normality.
module KS (
  tests
  ) where

import qualified Data.Vector.Unboxed as U

import Statistics.Test.KolmogorovSmirnov

import Statistics.Distribution
import Statistics.Distribution.Exponential
import Statistics.Distribution.Gamma
import Statistics.Distribution.Normal
import Statistics.Distribution.Uniform

import qualified System.Random.MWC               as MWC
import qualified System.Random.MWC.Distributions as MWC

import Test.HUnit hiding (Test)
import Test.Framework
import Test.Framework.Providers.HUnit


tests :: MWC.GenIO -> Test
tests g = testGroup "Kolmogorov-Smirnov"
  [ testCase "standard"           $ testKS standard           MWC.standard    g
  , testCase "normal m=1 s=2"     $ testKS (normalDistr 1 2) (MWC.normal 1 2) g
    -- Gamma distribution
  , testCase "gamma  k=1   θ=1"   $ testKS (gammaDistr  1   1  ) (MWC.gamma  1   1  ) g
  , testCase "gamma  k=0.3 θ=0.4" $ testKS (gammaDistr  0.3 0.4) (MWC.gamma  0.3 0.4) g
  , testCase "gamma  k=0.3 θ=3"   $ testKS (gammaDistr  0.3 3  ) (MWC.gamma  0.3 3  ) g
  , testCase "gamma  k=3   θ=0.4" $ testKS (gammaDistr  3   0.4) (MWC.gamma  3   0.4) g
  , testCase "gamma  k=3   θ=3"   $ testKS (gammaDistr  3   3  ) (MWC.gamma  3   3  ) g
    -- Uniform
  , testCase "uniform -2 .. 3"    $ testKS (uniformDistr (-2) 3) (MWC.uniformR (-2,3)) g
    -- Exponential
  , testCase "exponential l=1"    $ testKS (exponential 1)       (MWC.exponential 1) g
  , testCase "exponential l=3"    $ testKS (exponential 3)       (MWC.exponential 3) g
  ]

testKS :: (Distribution d) => d -> (MWC.GenIO -> IO Double) -> MWC.GenIO -> IO ()
testKS distr generator g = do
  sample <- U.replicateM 1000 (generator g)
  case kolmogorovSmirnovTest distr 0.01 sample of
    Significant    -> assertFailure "KS test failed"
    NotSignificant -> return ()
