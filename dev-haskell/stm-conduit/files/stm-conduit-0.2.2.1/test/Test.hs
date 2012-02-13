module Main ( main ) where

import Test.Framework (defaultMain, testGroup)
import Test.Framework.Providers.HUnit
import Test.Framework.Providers.QuickCheck2 (testProperty)

import Test.QuickCheck
import Test.HUnit

import Control.Concurrent
import Control.Concurrent.STM
import Data.Conduit
import Data.Conduit.List
import Data.Conduit.TMChan

main = defaultMain tests

tests = [
        testGroup "Behaves to spec" [
                testCase "simpleList" test_simpleList
            ],
        testGroup "Bug fixes" [
            ]
    ]

test_simpleList = do chan <- atomically $ newTMChan
                     forkIO . runResourceT $ sourceList testList $$ sinkTMChan chan
                     lst' <- runResourceT $ sourceTMChan chan $$ consume
                     assertEqual "for the numbers [1..10000]," testList lst'
                     closed <- atomically $ isClosedTMChan chan
                     assertBool "channel is closed after running" closed
    where
        testList = [1..10000]
