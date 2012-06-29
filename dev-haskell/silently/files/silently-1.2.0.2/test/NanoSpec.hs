-- | A lightweight implementation of Hspec's API.
--
-- We can not depend on Hspec for testing silently, so we define a lightweight
-- implementation of Hspec's API here.  For now only HUnit assertions are
-- supported as examples.
module NanoSpec where

import           Control.Monad
import           Control.Monad.Trans.Writer
import           Test.HUnit

type Spec = Writer [Test] ()

describe :: String -> Spec -> Spec
describe label = tell . return . TestLabel label . TestList . execWriter

context :: String -> Spec -> Spec
context = describe

it :: String -> Assertion -> Spec
it label = tell . return . TestLabel label . TestCase

hspec :: Spec -> IO ()
hspec = void . runTestTT . TestList . execWriter


-- Catchy combinators from https://github.com/sol/hspec-expectations
type Expectation = Assertion

infix 1 `shouldBe`, `shouldReturn`

shouldBe :: (Show a, Eq a) => a -> a -> Expectation
actual `shouldBe` expected = actual @?= expected

shouldReturn :: (Show a, Eq a) => IO a -> a -> Expectation
action `shouldReturn` expected = action >>= (`shouldBe` expected)