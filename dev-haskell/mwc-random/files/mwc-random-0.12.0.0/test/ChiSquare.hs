{-# LANGUAGE RecordWildCards #-}
-- Chi square tests for random generators
module ChiSquare ( 
  tests
  ) where

import Control.Applicative
import Control.Monad

import Data.Typeable
import Data.Word
import Data.List (find)
import qualified Data.Vector.Unboxed              as U
import qualified Data.Vector.Unboxed.Mutable      as M
import qualified System.Random.MWC                as MWC
import qualified System.Random.MWC.CondensedTable as MWC

import Statistics.Test.ChiSquared
import Statistics.Distribution
import Statistics.Distribution.Poisson
import Statistics.Distribution.Binomial

import Test.HUnit hiding (Test)
import Test.Framework
import Test.Framework.Providers.HUnit



----------------------------------------------------------------

tests :: MWC.GenIO -> Test
tests g = testGroup "Chi squared tests"
    -- Word8 tests
  [ uniformRTest (0,255 :: Word8) g
  , uniformRTest (0,254 :: Word8) g
  , uniformRTest (0,129 :: Word8) g
  , uniformRTest (0,126 :: Word8) g
  , uniformRTest (0,10  :: Word8) g
    -- * Tables
  , ctableTest   [1] g
  , ctableTest   [0.5,  0.5] g
  , ctableTest   [0.25, 0.25, 0.25, 0.25] g
  , ctableTest   [0.25, 0.5,  0.25] g
  , ctableTest   [1/3 , 1/3, 1/3] g
  , ctableTest   [0.1,  0.9] g
  , ctableTest   (replicate 10 0.1) g
    -- ** Poisson
  , poissonTest 0.2  g
  , poissonTest 1.32 g
  , poissonTest 6.8  g
  , poissonTest 100  g
    -- ** Binomial
  , binomialTest 4   0.5 g
  , binomialTest 10  0.1 g
  , binomialTest 10  0.6 g
  , binomialTest 10  0.8 g
  , binomialTest 100 0.3 g
  ]

----------------------------------------------------------------
-- | RNG and corresonding distribution
data Generator = Generator {
    generator    :: MWC.GenIO -> IO Int
  , probabilites :: U.Vector Double
  }

-- | Apply chi square test for a distribution
sampleTest :: Generator           -- ^ Generator to test
           -> Int                 -- ^ N of events
           -> MWC.GenIO           -- ^ PRNG state
           -> IO TestResult
sampleTest (Generator{..}) n g = do
  let size = U.length $ probabilites
  h <- histogram (generator g) size n
  let w = U.map (* fromIntegral n) probabilites
  return $ chi2test 0.05 0 $ U.zip h w
{-# INLINE sampleTest #-}

  
-- | Fill histogram using supplied generator
histogram :: IO Int             -- ^ Rangom generator
          -> Int                -- ^ N of outcomes 
          -> Int                -- ^ N of events
          -> IO (U.Vector Int)
histogram gen size n = do
  arr <- M.replicate size 0
  replicateM_ n $ do i <- gen
                     when (i < size) $ M.write arr i . (+1) =<< M.read arr i
  U.unsafeFreeze arr
{-# INLINE histogram #-}


-- | Test uniformR
uniformRTest :: (MWC.Variate a, Typeable a, Show a, Integral a) => (a,a) -> MWC.GenIO -> Test
uniformRTest (a,b) g = 
  testCase ("uniformR: " ++ show (a,b) ++ " :: " ++ show (typeOf a)) $ do
    let n   = fromIntegral b - fromIntegral a + 1
        gen = Generator { generator    = \g -> fromIntegral . subtract a <$> MWC.uniformR (a,b) g
                        , probabilites = U.replicate n (1 / fromIntegral n)
                        }
    r <- sampleTest gen (10^5) g
    assertEqual "Significant!" NotSignificant r
{-# INLINE uniformRTest #-}

-- | Test for condensed tables
ctableTest :: [Double] -> MWC.GenIO -> Test
ctableTest ps g = 
  testCase ("condensedTable: " ++ show ps) $ do
    let gen = Generator 
              { generator    = MWC.genFromTable $ MWC.tableFromProbabilities $ U.fromList $ zip [0..] ps
              , probabilites = U.fromList ps
              }
    r <- sampleTest gen (10^4) g
    assertEqual "Significant!" NotSignificant r

-- | Test for condensed table for poissson distribution
poissonTest :: Double -> MWC.GenIO -> Test
poissonTest lam g =
  testCase ("poissonTest: " ++ show lam) $ do
    let pois      = poisson lam
        Just nMax = find (\n -> probability pois n < 2**(-33)) [floor lam ..]
    let gen = Generator
              { generator    = MWC.genFromTable (MWC.tablePoisson lam)
              , probabilites = U.generate nMax (probability pois)
              }
    r <- sampleTest gen (10^4) g
    assertEqual "Significant!" NotSignificant r
    
binomialTest :: Int -> Double -> MWC.GenIO -> Test
binomialTest n p g =
  testCase ("binomialTest: " ++ show p ++ " " ++ show n) $ do
    let binom = binomial n p
        gen = Generator
              { generator    = MWC.genFromTable (MWC.tableBinomial n p)
              , probabilites = U.generate (n+1) (probability binom)
              }
    r <- sampleTest gen (10^4) g
    assertEqual "Significant!" NotSignificant r

