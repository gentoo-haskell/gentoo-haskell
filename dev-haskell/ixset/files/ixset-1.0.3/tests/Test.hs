module Test (tests) where

import Control.Monad (liftM)
import Control.Exception (catch)
import Data.IxSet.Tests (allTests)
import qualified Distribution.TestSuite as Cabal
import Prelude hiding (catch)
import Test.HUnit (errors, failures, putTextToShowS,runTestText, runTestTT)
import qualified Test.HUnit as HUnit
import System.Exit (exitFailure)
import System.IO (hIsTerminalDevice, stdout)

data HUnitTest = HUnitTest String HUnit.Test

-- | Convert an HUnit test into a named Cabal test.
test :: String -> HUnit.Test -> Cabal.Test
test n t = Cabal.impure $ HUnitTest n t

instance Cabal.TestOptions HUnitTest where
    name (HUnitTest n _) = n
    options _ = []
    defaultOptions _ = return $! Cabal.Options []
    check _ _ = []

instance Cabal.ImpureTestable HUnitTest where
    runM (HUnitTest _ t) _ =
        catch go (\e -> return . Cabal.Error . show $ (e :: IOError))
        where
            start :: HUnit.State -> Cabal.Result -> IO Cabal.Result
            start _ x = return x
            anError :: String -> HUnit.State -> Cabal.Result -> IO Cabal.Result
            anError msg _ _ = return $ Cabal.Error msg
            failure :: String -> HUnit.State -> Cabal.Result -> IO Cabal.Result
            failure msg _ _ = return $ Cabal.Fail msg
            go = liftM snd
                $ HUnit.performTest start anError failure Cabal.Pass t

tests :: [Cabal.Test]
tests = map (test "ixset") allTests
