{-# LANGUAGE OverloadedStrings #-}
module Bytea where

import Data.ByteString              (ByteString)
import Data.Text                    (Text)
import Database.PostgreSQL.Simple
import Test.HUnit

import qualified Crypto.Hash.MD5    as MD5
import qualified Data.ByteString    as B
import qualified Data.ByteString.Base16 as Base16
import qualified Data.Text.Encoding as TE

testBytea :: Connection -> Test
testBytea conn = TestList
    [ testStr "empty"                  []
    , testStr "\"hello\""              $ map (fromIntegral . fromEnum) ("hello" :: String)
    , testStr "ascending"              [0..255]
    , testStr "descending"             [255,254..0]
    , testStr "ascending, doubled up"  $ doubleUp [0..255]
    , testStr "descending, doubled up" $ doubleUp [255,254..0]
    ]
  where
    testStr label bytes = TestLabel label $ TestCase $ do
        let bs = B.pack bytes

        [Only h] <- query conn "SELECT md5(?::bytea)" [Binary bs]
        assertBool "Haskell -> SQL conversion altered the string" $ md5 bs == h

        [Only (Binary r)] <- query conn "SELECT ?::bytea" [Binary bs]
        assertBool "SQL -> Haskell conversion altered the string" $ bs == r

    doubleUp = concatMap (\x -> [x, x])

md5 :: ByteString -> Text
md5 = TE.decodeUtf8 . Base16.encode . MD5.hash
