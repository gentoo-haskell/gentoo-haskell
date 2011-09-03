{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}
import Test.HUnit hiding (Test)
import Test.Hspec
import Test.Hspec.HUnit

import Prelude hiding (reverse)
import Text.Cassius
import Text.Lucius
import Data.List (intercalate)
import qualified Data.Text.Lazy as T
import qualified Data.List
import qualified Data.List as L
import Data.Text (Text, pack, unpack)
import Data.Monoid (mappend)

main :: IO ()
main = hspecX $ descriptions [specs]

specs = describe "hamlet"
  [ it "cassius" caseCassius
  , it "cassiusFile" caseCassiusFile

  , it "cassiusFileDebug" $ do
    let var = "var"
    let selector = "foo"
    let urlp = (Home, [(pack "p", pack "q")])
    flip celper $(cassiusFileDebug "test/external1.cassius") $ concat
        [ "foo{background:#000;bar:baz;color:#F00}"
        , "bin{"
        , "background-image:url(url);"
        , "bar:bar;color:#7F6405;fvarx:someval;unicode-test:שלום;"
        , "urlp:url(url?p=q)}"
        ]

{- TODO
  , it "cassiusFileDebugChange" $ do
    let var = "var"
    writeFile "test/external2.cassius" "foo\n  #{var}: 1"
    celper "foo{var:1}" $(cassiusFileDebug "test/external2.cassius")
    writeFile "test/external2.cassius" "foo\n  #{var}: 2"
    celper "foo{var:2}" $(cassiusFileDebug "test/external2.cassius")
    writeFile "test/external2.cassius" "foo\n  #{var}: 1"
    -}


  , it "comments" $ do
    -- FIXME reconsider Hamlet comment syntax?
    celper "" [cassius|/* this is a comment */
/* another comment */
/*a third one*/|]


  , it "cassius pseudo-class" $
    flip celper [cassius|
a:visited
    color: blue
|] "a:visited{color:blue}"


  , it "ignores a blank line" $ do
    celper "foo{bar:baz}" [cassius|
foo

    bar: baz

|]


  , it "leading spaces" $
    celper "foo{bar:baz}" [cassius|
  foo
    bar: baz
|]


  , it "cassius all spaces" $
    celper "h1{color:green }" [cassius|
    h1
        color: green 
    |]


  , it "cassius whitespace and colons" $ do
    celper "h1:hover{color:green ;font-family:sans-serif}" [cassius|
    h1:hover
        color: green 
        font-family:sans-serif
    |]


  , it "cassius trailing comments" $
    celper "h1:hover {color:green ;font-family:sans-serif}" [cassius|
    h1:hover /* Please ignore this */
        color: green /* This is a comment. */
        /* Obviously this is ignored too. */
        font-family:sans-serif
    |]



  , it "cassius module names" $
    let foo = "foo" in
      celper "sel{bar:oof oof 3.14 -5}"
        [cassius|
sel
    bar: #{Data.List.reverse foo} #{L.reverse foo} #{show 3.14} #{show -5}
|]



  , it "single dollar at and caret" $ do
    celper "sel{att:$@^}" [cassius|
sel
    att: $@^
|]

    celper "sel{att:#{@{^{}" [cassius|
sel
    att: #\{@\{^{
|]


  , it "dollar operator" $ do
    let val = (1, (2, 3))
    celper "sel{att:2}" [cassius|
sel
    att: #{ show $ fst $ snd val }
|]
    celper "sel{att:2}" [cassius|
sel
    att: #{ show $ fst $ snd $ val}
|]



  , it "embedded slash" $ do
    celper "sel{att:///}" [cassius|
sel
    att: ///
|]






  , it "multi cassius" $ do
    celper "foo{bar:baz;bar:bin}" [cassius|
foo
    bar: baz
    bar: bin
|]






  , it "lucius" $ do
    let var = "var"
    let urlp = (Home, [(pack "p", pack "q")])
    flip celper [lucius|
foo {
    background: #{colorBlack};
    bar: baz;
    color: #{colorRed};
}
bin {
        background-image: url(@{Home});
        bar: bar;
        color: #{(((Color 127) 100) 5)};
        f#{var}x: someval;
        unicode-test: שלום;
        urlp: url(@?{urlp});
}
|] $ concat
        [ "foo{background:#000;bar:baz;color:#F00}"
        , "bin{"
        , "background-image:url(url);"
        , "bar:bar;color:#7F6405;fvarx:someval;unicode-test:שלום;"
        , "urlp:url(url?p=q)}"
        ]



  , it "lucius file" $ do
      let var = "var"
      let urlp = (Home, [(pack "p", pack "q")])
      flip celper $(luciusFile "test/external1.lucius") $ concat
          [ "foo{background:#000;bar:baz;color:#F00}"
          , "bin{"
          , "background-image:url(url);"
          , "bar:bar;color:#7F6405;fvarx:someval;unicode-test:שלום;"
          , "urlp:url(url?p=q)}"
          ]

{-
  , it "lucius file debug" caseLuciusFileDebug
  -}




  , it "lucius nested" $ do
      celper "foo bar{baz:bin}" $(luciusFile "test/external-nested.lucius")
      celper "foo bar{baz:bin}" $(luciusFileDebug "test/external-nested.lucius")
      celper "foo bar{baz:bin}" [lucius|
        foo {
            bar {
                baz: bin;
            }
        }
        |]
      celper "foo1 bar,foo2 bar{baz:bin}" [lucius|
        foo1, foo2 {
            bar {
                baz: bin;
            }
        }
        |]


  , it "lucius media" $ do
      celper "@media only screen{foo bar{baz:bin}}" $(luciusFile "test/external-media.lucius")
      celper "@media only screen{foo bar{baz:bin}}" $(luciusFileDebug "test/external-media.lucius")
      celper "@media only screen{foo bar{baz:bin}}" [lucius|
        @media only screen{
            foo {
                bar {
                    baz: bin;
                }
            }
        }
        |]


  , it "cassius removes whitespace" $ do
      celper "foo{bar:baz}" [cassius|
      foo
          bar     :    baz
      |]





  , it "lucius trailing comments" $
      celper "foo{bar:baz}" [lucius|foo{bar:baz;}/* ignored*/|]
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



celper :: String -> CssUrl Url -> Assertion
celper res h = do
    let x = renderCssUrl render h
    T.pack res @=? x

caseCassius :: Assertion
caseCassius = do
    let var = "var"
    let urlp = (Home, [(pack "p", pack "q")])
    flip celper [cassius|
foo
    background: #{colorBlack}
    bar: baz
    color: #{colorRed}
bin
        background-image: url(@{Home})
        bar: bar
        color: #{(((Color 127) 100) 5)}
        f#{var}x: someval
        unicode-test: שלום
        urlp: url(@?{urlp})
|] $ concat
        [ "foo{background:#000;bar:baz;color:#F00}"
        , "bin{"
        , "background-image:url(url);"
        , "bar:bar;color:#7F6405;fvarx:someval;unicode-test:שלום;"
        , "urlp:url(url?p=q)}"
        ]

caseCassiusFile :: Assertion
caseCassiusFile = do
    let var = "var"
    let selector = "foo"
    let urlp = (Home, [(pack "p", pack "q")])
    flip celper $(cassiusFile "test/external1.cassius") $ concat
        [ "foo{background:#000;bar:baz;color:#F00}"
        , "bin{"
        , "background-image:url(url);"
        , "bar:bar;color:#7F6405;fvarx:someval;unicode-test:שלום;"
        , "urlp:url(url?p=q)}"
        ]

instance Show Url where
    show _ = "FIXME remove this instance show Url"


caseLuciusFileDebug :: Assertion
caseLuciusFileDebug = do
    let var = "var"
    writeFile "test/external2.lucius" "foo{#{var}: 1}"
    celper "foo{var:1}" $(luciusFileDebug "test/external2.lucius")
    writeFile "test/external2.lucius" "foo{#{var}: 2}"
    celper "foo{var:2}" $(luciusFileDebug "test/external2.lucius")
    writeFile "test/external2.lucius" "foo{#{var}: 1}"
