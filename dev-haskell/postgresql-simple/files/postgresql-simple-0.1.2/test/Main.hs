{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE NamedFieldPuns #-}

import Control.Exception            (bracket)
import Control.Monad                (when)
import Database.PostgreSQL.Simple
import System.Exit                  (exitFailure)
import System.IO
import Test.HUnit

import Bytea

tests :: Connection -> [Test]
tests conn =
    [ TestLabel "Bytea" $ testBytea conn
    ]

main :: IO ()
main = do
    mapM_ (`hSetBuffering` LineBuffering) [stdout, stderr]
    bracket (connectPostgreSQL "") close $ \conn -> do
        Counts{cases, tried, errors, failures} <- runTestTT $ TestList $ tests conn
        when (cases /= tried || errors /= 0 || failures /= 0) $ exitFailure
