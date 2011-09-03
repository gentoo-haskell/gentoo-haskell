{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}
import Test.HUnit hiding (Test)
import Test.Hspec
import Test.Hspec.HUnit ()

import Prelude hiding (reverse)
import Text.Julius
import Data.List (intercalate)
import qualified Data.Text.Lazy as T
import qualified Data.List
import qualified Data.List as L
import Data.Text (Text, pack, unpack)
import Data.Monoid (mappend)

main :: IO ()
main = hspecX $ descriptions [specs]

specs :: IO [IO Spec]
specs = describe "hamlet"
  [ it "julius" $ do
    let var = "var"
    let urlp = (Home, [(pack "p", pack "q")])
    flip jelper [julius|שלום
#{var}
@{Home}
@?{urlp}
^{jmixin}
|] $ intercalate "\r\n"
        [ "שלום"
        , var
        , "url"
        , "url?p=q"
        , "var x;"
        ] ++ "\r\n"


  , it "juliusFile" $ do
    let var = "var"
    let urlp = (Home, [(pack "p", pack "q")])
    flip jelper $(juliusFile "test/external1.julius") $ unlines
        [ "שלום"
        , var
        , "url"
        , "url?p=q"
        , "var x;"
        ]


  , it "juliusFileDebug" $ do
    let var = "var"
    let urlp = (Home, [(pack "p", pack "q")])
    flip jelper $(juliusFileDebug "test/external1.julius") $ unlines
        [ "שלום"
        , var
        , "url"
        , "url?p=q"
        , "var x;"
        ]

{- TODO
  , it "juliusFileDebugChange" $ do
      let var = "somevar"
          test result = jelper result $(juliusFileDebug "test/external2.julius")
      writeFile "test/external2.julius" "var #{var} = 1;"
      test "var somevar = 1;"
      writeFile "test/external2.julius" "var #{var} = 2;"
      test "var somevar = 2;"
      writeFile "test/external2.julius" "var #{var} = 1;"
      -}


  , it "julius module names" $
    let foo = "foo"
        double = 3.14 :: Double
        int = -5 :: Int in
      jelper "oof oof 3.14 -5"
        [julius|#{Data.List.reverse foo} #{L.reverse foo} #{show double} #{show int}|]


  , it "single dollar at and caret" $ do
    jelper "$@^" [julius|$@^|]
    jelper "#{@{^{" [julius|#\{@\{^\{|]


  , it "dollar operator" $ do
    let val = (1 :: Int, (2 :: Int, 3 :: Int))
    jelper "2" [julius|#{ show $ fst $ snd val }|]
    jelper "2" [julius|#{ show $ fst $ snd $ val}|]
  ]



data Url = Home | Sub SubUrl
data SubUrl = SubUrl
render :: Url -> [(Text, Text)] -> Text
render Home qs = pack "url" `mappend` showParams qs
render (Sub SubUrl) qs = pack "suburl" `mappend` showParams qs

showParams :: [(Text, Text)] -> Text
showParams [] = pack ""
showParams z =
    pack $ '?' : intercalate "&" (map go z)
  where
    go (x, y) = go' x ++ '=' : go' y
    go' = concatMap encodeUrlChar . unpack

-- | Taken straight from web-encodings; reimplemented here to avoid extra
-- dependencies.
encodeUrlChar :: Char -> String
encodeUrlChar c
    -- List of unreserved characters per RFC 3986
    -- Gleaned from http://en.wikipedia.org/wiki/Percent-encoding
    | 'A' <= c && c <= 'Z' = [c]
    | 'a' <= c && c <= 'z' = [c]
    | '0' <= c && c <= '9' = [c]
encodeUrlChar c@'-' = [c]
encodeUrlChar c@'_' = [c]
encodeUrlChar c@'.' = [c]
encodeUrlChar c@'~' = [c]
encodeUrlChar ' ' = "+"
encodeUrlChar y =
    let (a, c) = fromEnum y `divMod` 16
        b = a `mod` 16
        showHex' x
            | x < 10 = toEnum $ x + (fromEnum '0')
            | x < 16 = toEnum $ x - 10 + (fromEnum 'A')
            | otherwise = error $ "Invalid argument to showHex: " ++ show x
     in ['%', showHex' b, showHex' c]




jmixin :: JavascriptUrl u
jmixin = [julius|var x;|]

jelper :: String -> JavascriptUrl Url -> Assertion
jelper res h = T.pack res @=? renderJavascriptUrl render h

instance Show Url where
    show _ = "FIXME remove this instance show Url"
