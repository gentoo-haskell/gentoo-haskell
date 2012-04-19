module Main where

import Control.Applicative
import Control.Monad

import Test.QuickCheck hiding ((.&.))
import Test.Framework (Test, defaultMain, testGroup)
import Test.Framework.Providers.QuickCheck2 (testProperty)

import Data.PEM
import qualified Data.ByteString as B

main :: IO ()
main = defaultMain tests

tests :: [Test]
tests =
    [ testProperty "marshall" testMarshall
    ]

testMarshall pems = readPems == Right pems
    where readPems = pemParseBS writtenPems
          writtenPems = B.concat (map pemWriteBS pems)

arbitraryName = choose (1, 30) >>= \i -> replicateM i arbitraryAscii
    where arbitraryAscii = elements ['A'..'Z']

arbitraryContent = choose (1,10) >>= \i ->
                   (B.pack . map fromIntegral) `fmap` replicateM i (choose (0,255) :: Gen Int)

instance Arbitrary PEM where
    arbitrary = PEM <$> arbitraryName <*> pure [] <*> arbitraryContent
