-- Generates samples of value for display with visual.R
import Control.Monad

import System.Directory  (createDirectoryIfMissing,setCurrentDirectory)
import System.IO

import qualified System.Random.MWC                as MWC
import qualified System.Random.MWC.Distributions  as MWC
import qualified System.Random.MWC.CondensedTable as MWC


dumpSample :: Show a => Int -> FilePath -> IO a -> IO ()
dumpSample n fname gen =
  withFile fname WriteMode $ \h -> 
    replicateM_ n (hPutStrLn h . show =<< gen)

main :: IO ()
main = MWC.withSystemRandom $ \g -> do
  let n   = 30000
      dir = "distr"
  createDirectoryIfMissing True dir
  setCurrentDirectory           dir
  -- Normal
  dumpSample n "normal-0-1" $ MWC.normal 0 1 g
  dumpSample n "normal-1-2" $ MWC.normal 1 2 g
  -- Gamma
  dumpSample n "gamma-1.0-1.0" $ MWC.gamma  1.0 1.0 g
  dumpSample n "gamma-0.3-0.4" $ MWC.gamma  0.3 0.4 g
  dumpSample n "gamma-0.3-3.0" $ MWC.gamma  0.3 3.0 g
  dumpSample n "gamma-3.0-0.4" $ MWC.gamma  3.0 0.4 g
  dumpSample n "gamma-3.0-3.0" $ MWC.gamma  3.0 3.0 g
  -- Exponential
  dumpSample n "exponential-1" $ MWC.exponential 1 g
  dumpSample n "exponential-3" $ MWC.exponential 3 g
  -- Poisson
  dumpSample n "poisson-0.1"   $ MWC.genFromTable (MWC.tablePoisson 0.1) g
  dumpSample n "poisson-1.0"   $ MWC.genFromTable (MWC.tablePoisson 1.0) g
  dumpSample n "poisson-4.5"   $ MWC.genFromTable (MWC.tablePoisson 4.5) g
  dumpSample n "poisson-30"    $ MWC.genFromTable (MWC.tablePoisson 30)  g
  -- Binomial
  dumpSample n "binom-4-0.5"   $ MWC.genFromTable (MWC.tableBinomial 4  0.5) g
  dumpSample n "binom-10-0.1"  $ MWC.genFromTable (MWC.tableBinomial 10 0.1) g  
  dumpSample n "binom-10-0.6"  $ MWC.genFromTable (MWC.tableBinomial 10 0.6) g
  dumpSample n "binom-10-0.8"  $ MWC.genFromTable (MWC.tableBinomial 10 0.8) g
