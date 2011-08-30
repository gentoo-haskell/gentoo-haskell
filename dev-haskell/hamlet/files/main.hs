{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}
import Test.HUnit hiding (Test)
import Test.Hspec
import Test.Hspec.HUnit

import Prelude hiding (reverse)
import Text.Hamlet
import Data.List (intercalate)
import qualified Data.Text.Lazy as T
import qualified Data.List
import qualified Data.List as L
import qualified Data.Map as Map
import Data.Text (Text, pack, unpack)
import Data.Monoid (mappend)
import qualified Data.Set as Set
import qualified Text.Blaze.Renderer.Text
import Text.Blaze (toHtml, preEscapedString)

main :: IO ()
main = hspecX $ descriptions [specs]

specs = describe "hamlet"
  [ it "empty" caseEmpty
  , it "static" caseStatic
  , it "tag" caseTag
  , it "var" caseVar
  , it "var chain " caseVarChain
  , it "url" caseUrl
  , it "url chain " caseUrlChain
  , it "embed" caseEmbed
  , it "embed chain " caseEmbedChain
  , it "if" caseIf
  , it "if chain " caseIfChain
  , it "else" caseElse
  , it "else chain " caseElseChain
  , it "elseif" caseElseIf
  , it "elseif chain " caseElseIfChain
  , it "list" caseList
  , it "list chain" caseListChain
  , it "with" caseWith
  , it "with multi" caseWithMulti
  , it "with chain" caseWithChain
  , it "with comma string" caseWithCommaString
  , it "with multi scope" caseWithMultiBindingScope
  , it "script not empty" caseScriptNotEmpty
  , it "meta empty" caseMetaEmpty
  , it "input empty" caseInputEmpty
  , it "multiple classes" caseMultiClass
  , it "attrib order" caseAttribOrder
  , it "nothing" caseNothing
  , it "nothing chain " caseNothingChain
  , it "just" caseJust
  , it "just chain " caseJustChain
  , it "constructor" caseConstructor
  , it "url + params" caseUrlParams
  , it "escape" caseEscape
  , it "empty statement list" caseEmptyStatementList
  , it "attribute conditionals" caseAttribCond
  , it "non-ascii" caseNonAscii
  , it "maybe function" caseMaybeFunction
  , it "trailing dollar sign" caseTrailingDollarSign
  , it "non leading percent sign" caseNonLeadingPercent
  , it "quoted attributes" caseQuotedAttribs
  , it "spaced derefs" caseSpacedDerefs
  , it "attrib vars" caseAttribVars
  , it "strings and html" caseStringsAndHtml
  , it "nesting" caseNesting
  , it "trailing space" caseTrailingSpace
  , it "currency symbols" caseCurrency
  , it "external" caseExternal
  , it "parens" caseParens
  , it "hamlet literals" caseHamletLiterals
  , it "hamlet' and xhamlet'" caseHamlet'



  , it "comments" $ do
    -- FIXME reconsider Hamlet comment syntax?
    helper "" [hamlet|$# this is a comment
$# another comment
$#a third one|]


  , it "ignores a blank line" $ do
    helper "<p>foo</p>" [hamlet|
<p

    foo

|]




  , it "hamlet angle bracket syntax" $
      helper "<p class=\"foo\" height=\"100\"><span id=\"bar\" width=\"50\">HELLO</span></p>"
        [hamlet|
<p.foo height="100"
    <span #bar width=50>HELLO
|]



  , it "hamlet module names" $
    let foo = "foo" in
      helper "oof oof 3.14 -5"
        [hamlet|#{Data.List.reverse foo} #
#{L.reverse foo} #
#{show 3.14} #{show -5}|]





  , it "single dollar at and caret" $ do
    helper "$@^" [hamlet|$@^|]

    helper "#{@{^{" [hamlet|#\{@\{^\{|]


  , it "dollar operator" $ do
    let val = (1, (2, 3))
    helper "2" [hamlet|#{ show $ fst $ snd val }|]
    helper "2" [hamlet|#{ show $ fst $ snd $ val}|]


  , it "in a row" $ do
    helper "1" [hamlet|#{ show $ const 1 2 }|]


  , it "embedded slash" $ do
    helper "///" [hamlet|///|]


  , it "string literals" $ do
    helper "string" [hamlet|#{"string"}|]
    helper "string" [hamlet|#{id "string"}|]
    helper "gnirts" [hamlet|#{L.reverse $ id "string"}|]
    helper "str&quot;ing" [hamlet|#{"str\"ing"}|]
    helper "str&lt;ing" [hamlet|#{"str<ing"}|]


  , it "interpolated operators" $ do
    helper "3" [hamlet|#{show $ (+) 1 2}|]
    helper "6" [hamlet|#{show $ sum $ (:) 1 ((:) 2 $ return 3)}|]


  , it "HTML comments" $ do
    helper "<p>1</p><p>2 not ignored</p>" [hamlet|
<p>1
<!-- ignored comment -->
<p
    2
    <!-- ignored --> not ignored<!-- ignored -->
|]



  , it "nested maybes" $ do
    let muser = Just "User" :: Maybe String
        mprof = Nothing :: Maybe Int
        m3 = Nothing :: Maybe String
    helper "justnothing" [hamlet|
$maybe user <- muser
    $maybe profile <- mprof
        First two are Just
        $maybe desc <- m3
            \ and left us a description:
            <p>#{desc}
        $nothing
        and has left us no description.
    $nothing
        justnothing
$nothing
    <h1>No such Person exists.
   |]







  , it "conditional class" $ do
      helper "<p class=\"current\"></p>" 
        [hamlet|<p :False:.ignored :True:.current|]

      helper "<p class=\"1 3 2 4\"></p>"
        [hamlet|<p :True:.1 :True:class=2 :False:.a :False:class=b .3 class=4|]

      helper "<p class=\"foo bar baz\"></p>"
        [hamlet|<p class=foo class=bar class=baz|]




  , it "forall on Foldable" $ do
      let set = Set.fromList [1..5 :: Int]
      helper "12345" [hamlet|
$forall x <- set
  #{x}
|]



  , it "non-poly HTML" $ do
      helperHtml "<h1>HELLO WORLD</h1>" [shamlet|
  <h1>HELLO WORLD
  |]
      helperHtml "<h1>HELLO WORLD</h1>" $(shamletFile "test/nonpolyhtml.hamlet")


  , it "non-poly Hamlet" $ do
      let embed = [hamlet|<p>EMBEDDED|]
      helper "<h1>url</h1><p>EMBEDDED</p>" [hamlet|
  <h1>@{Home}
  ^{embed}
  |]
      helper "<h1>url</h1>" $(hamletFile "test/nonpolyhamlet.hamlet")

  , it "non-poly IHamlet" $ do
      let embed = [ihamlet|<p>EMBEDDED|]
      ihelper "<h1>Adios</h1><p>EMBEDDED</p>" [ihamlet|
  <h1>_{Goodbye}
  ^{embed}
  |]
      ihelper "<h1>Hola</h1>" $(ihamletFile "test/nonpolyihamlet.hamlet")
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

data Arg url = Arg
    { getArg :: Arg url
    , var :: Html
    , url :: Url
    , embed :: HtmlUrl url
    , true :: Bool
    , false :: Bool
    , list :: [Arg url]
    , nothing :: Maybe String
    , just :: Maybe String
    , urlParams :: (Url, [(Text, Text)])
    }

theArg :: Arg url
theArg = Arg
    { getArg = theArg
    , var = toHtml "<var>"
    , url = Home
    , embed = [hamlet|embed|]
    , true = True
    , false = False
    , list = [theArg, theArg, theArg]
    , nothing = Nothing
    , just = Just "just"
    , urlParams = (Home, [(pack "foo", pack "bar"), (pack "foo1", pack "bar1")])
    }

helperHtml :: String -> Html -> Assertion
helperHtml res h = do
    let x = Text.Blaze.Renderer.Text.renderHtml h
    T.pack res @=? x

helper :: String -> HtmlUrl Url -> Assertion
helper res h = do
    let x = Text.Blaze.Renderer.Text.renderHtml $ h render
    T.pack res @=? x

caseEmpty :: Assertion
caseEmpty = helper "" [hamlet||]

caseStatic :: Assertion
caseStatic = helper "some static content" [hamlet|some static content|]

caseTag :: Assertion
caseTag = do
    helper "<p class=\"foo\"><div id=\"bar\">baz</div></p>" [hamlet|
<p .foo
  <#bar>baz
|]
    helper "<p class=\"foo.bar\"><div id=\"bar\">baz</div></p>" [hamlet|
<p class=foo.bar
  <#bar>baz
|]

caseVar :: Assertion
caseVar = do
    helper "&lt;var&gt;" [hamlet|#{var theArg}|]

caseVarChain :: Assertion
caseVarChain = do
    helper "&lt;var&gt;" [hamlet|#{var (getArg (getArg (getArg theArg)))}|]

caseUrl :: Assertion
caseUrl = do
    helper (unpack $ render Home []) [hamlet|@{url theArg}|]

caseUrlChain :: Assertion
caseUrlChain = do
    helper (unpack $ render Home []) [hamlet|@{url (getArg (getArg (getArg theArg)))}|]

caseEmbed :: Assertion
caseEmbed = do
    helper "embed" [hamlet|^{embed theArg}|]

caseEmbedChain :: Assertion
caseEmbedChain = do
    helper "embed" [hamlet|^{embed (getArg (getArg (getArg theArg)))}|]

caseIf :: Assertion
caseIf = do
    helper "if" [hamlet|
$if true theArg
    if
|]

caseIfChain :: Assertion
caseIfChain = do
    helper "if" [hamlet|
$if true (getArg (getArg (getArg theArg)))
    if
|]

caseElse :: Assertion
caseElse = helper "else" [hamlet|
$if false theArg
    if
$else
    else
|]

caseElseChain :: Assertion
caseElseChain = helper "else" [hamlet|
$if false (getArg (getArg (getArg theArg)))
    if
$else
    else
|]

caseElseIf :: Assertion
caseElseIf = helper "elseif" [hamlet|
$if false theArg
    if
$elseif true theArg
    elseif
$else
    else
|]

caseElseIfChain :: Assertion
caseElseIfChain = helper "elseif" [hamlet|
$if false(getArg(getArg(getArg theArg)))
    if
$elseif true(getArg(getArg(getArg theArg)))
    elseif
$else
    else
|]

caseList :: Assertion
caseList = do
    helper "xxx" [hamlet|
$forall _x <- (list theArg)
    x
|]

caseListChain :: Assertion
caseListChain = do
    helper "urlurlurl" [hamlet|
$forall x <-  list(getArg(getArg(getArg(getArg(getArg (theArg))))))
    @{url x}
|]

caseWith :: Assertion
caseWith = do
    helper "it's embedded" [hamlet|
$with n <- embed theArg
    it's ^{n}ded
|]

caseWithMulti :: Assertion
caseWithMulti = do
    helper "it's embedded" [hamlet|
$with n <- embed theArg, m <- true theArg
    $if m
        it's ^{n}ded
|]

caseWithChain :: Assertion
caseWithChain = do
    helper "it's true" [hamlet|
$with n <- true(getArg(getArg(getArg(getArg theArg))))
    $if n
        it's true
|]

-- in multi-with binding, make sure that a comma in a string doesn't confuse the parser.
caseWithCommaString :: Assertion
caseWithCommaString = do
    helper "it's  , something" [hamlet|
$with n <- " , something"
    it's #{n}
|]

caseWithMultiBindingScope :: Assertion
caseWithMultiBindingScope = do
    helper "it's  , something" [hamlet|
$with n <- " , something", y <- n
    it's #{y}
|]

caseScriptNotEmpty :: Assertion
caseScriptNotEmpty = helper "<script></script>" [hamlet|<script|]

caseMetaEmpty :: Assertion
caseMetaEmpty = do
    helper "<meta>" [hamlet|<meta|]
    helper "<meta/>" [xhamlet|<meta|]
    helper "<meta>" [hamlet|<meta>|]
    helper "<meta/>" [xhamlet|<meta>|]

caseInputEmpty :: Assertion
caseInputEmpty = do
    helper "<input>" [hamlet|<input|]
    helper "<input/>" [xhamlet|<input|]
    helper "<input>" [hamlet|<input>|]
    helper "<input/>" [xhamlet|<input>|]

caseMultiClass :: Assertion
caseMultiClass = do
    helper "<div class=\"foo bar\"></div>" [hamlet|<.foo.bar|]
    helper "<div class=\"foo bar\"></div>" [hamlet|<.foo.bar>|]

caseAttribOrder :: Assertion
caseAttribOrder = do
    helper "<meta 1 2 3>" [hamlet|<meta 1 2 3|]
    helper "<meta 1 2 3>" [hamlet|<meta 1 2 3>|]

caseNothing :: Assertion
caseNothing = do
    helper "" [hamlet|
$maybe _n <- nothing theArg
    nothing
|]
    helper "nothing" [hamlet|
$maybe _n <- nothing theArg
    something
$nothing
    nothing
|]

caseNothingChain :: Assertion
caseNothingChain = helper "" [hamlet|
$maybe n <- nothing(getArg(getArg(getArg theArg)))
    nothing #{n}
|]

caseJust :: Assertion
caseJust = helper "it's just" [hamlet|
$maybe n <- just theArg
    it's #{n}
|]

caseJustChain :: Assertion
caseJustChain = helper "it's just" [hamlet|
$maybe n <- just(getArg(getArg(getArg theArg)))
    it's #{n}
|]

caseConstructor :: Assertion
caseConstructor = do
    helper "url" [hamlet|@{Home}|]
    helper "suburl" [hamlet|@{Sub SubUrl}|]
    let text = "<raw text>"
    helper "<raw text>" [hamlet|#{preEscapedString text}|]

caseUrlParams :: Assertion
caseUrlParams = do
    helper "url?foo=bar&amp;foo1=bar1" [hamlet|@?{urlParams theArg}|]

caseEscape :: Assertion
caseEscape = do
    helper "#this is raw\n " [hamlet|
\#this is raw
\
\ 
|]
    helper "$@^" [hamlet|$@^|]

caseEmptyStatementList :: Assertion
caseEmptyStatementList = do
    helper "" [hamlet|$if True|]
    helper "" [hamlet|$maybe _x <- Nothing|]
    let emptyList = []
    helper "" [hamlet|$forall _x <- emptyList|]

caseAttribCond :: Assertion
caseAttribCond = do
    helper "<select></select>" [hamlet|<select :False:selected|]
    helper "<select selected></select>" [hamlet|<select :True:selected|]
    helper "<meta var=\"foo:bar\">" [hamlet|<meta var=foo:bar|]
    helper "<select selected></select>"
        [hamlet|<select :true theArg:selected|]

    helper "<select></select>" [hamlet|<select :False:selected>|]
    helper "<select selected></select>" [hamlet|<select :True:selected>|]
    helper "<meta var=\"foo:bar\">" [hamlet|<meta var=foo:bar>|]
    helper "<select selected></select>"
        [hamlet|<select :true theArg:selected>|]

caseNonAscii :: Assertion
caseNonAscii = do
    helper "עִבְרִי" [hamlet|עִבְרִי|]

caseMaybeFunction :: Assertion
caseMaybeFunction = do
    helper "url?foo=bar&amp;foo1=bar1" [hamlet|
$maybe x <- Just urlParams
    @?{x theArg}
|]

caseTrailingDollarSign :: Assertion
caseTrailingDollarSign =
    helper "trailing space \ndollar sign #" [hamlet|trailing space #
\
dollar sign #\
|]

caseNonLeadingPercent :: Assertion
caseNonLeadingPercent =
    helper "<span style=\"height:100%\">foo</span>" [hamlet|
<span style=height:100%>foo
|]

caseQuotedAttribs :: Assertion
caseQuotedAttribs =
    helper "<input type=\"submit\" value=\"Submit response\">" [hamlet|
<input type=submit value="Submit response"
|]

caseSpacedDerefs :: Assertion
caseSpacedDerefs = do
    helper "&lt;var&gt;" [hamlet|#{var theArg}|]
    helper "<div class=\"&lt;var&gt;\"></div>" [hamlet|<.#{var theArg}|]

caseAttribVars :: Assertion
caseAttribVars = do
    helper "<div id=\"&lt;var&gt;\"></div>" [hamlet|<##{var theArg}|]
    helper "<div class=\"&lt;var&gt;\"></div>" [hamlet|<.#{var theArg}|]
    helper "<div f=\"&lt;var&gt;\"></div>" [hamlet|< f=#{var theArg}|]

    helper "<div id=\"&lt;var&gt;\"></div>" [hamlet|<##{var theArg}>|]
    helper "<div class=\"&lt;var&gt;\"></div>" [hamlet|<.#{var theArg}>|]
    helper "<div f=\"&lt;var&gt;\"></div>" [hamlet|< f=#{var theArg}>|]

caseStringsAndHtml :: Assertion
caseStringsAndHtml = do
    let str = "<string>"
    let html = preEscapedString "<html>"
    helper "&lt;string&gt; <html>" [hamlet|#{str} #{html}|]

caseNesting :: Assertion
caseNesting = do
    helper
      "<table><tbody><tr><td>1</td></tr><tr><td>2</td></tr></tbody></table>"
      [hamlet|
<table
  <tbody
    $forall user <- users
        <tr
         <td>#{user}
|]
    helper
        (concat
          [ "<select id=\"foo\" name=\"foo\"><option selected></option>"
          , "<option value=\"true\">Yes</option>"
          , "<option value=\"false\">No</option>"
          , "</select>"
          ])
        [hamlet|
<select #"#{name}" name=#{name}
    <option :isBoolBlank val:selected
    <option value=true :isBoolTrue val:selected>Yes
    <option value=false :isBoolFalse val:selected>No
|]
  where
    users = ["1", "2"]
    name = "foo"
    val = 5 :: Int
    isBoolBlank _ = True
    isBoolTrue _ = False
    isBoolFalse _ = False

caseTrailingSpace :: Assertion
caseTrailingSpace =
    helper "" [hamlet|        |]

caseCurrency :: Assertion
caseCurrency =
    helper foo [hamlet|#{foo}|]
  where
    foo = "eg: 5, $6, €7.01, £75"

caseExternal :: Assertion
caseExternal = do
    helper "foo<br>" $(hamletFile "test/external.hamlet")
    helper "foo<br/>" $(xhamletFile "test/external.hamlet")
  where
    foo = "foo"

caseParens :: Assertion
caseParens = do
    let plus = (++)
        x = "x"
        y = "y"
    helper "xy" [hamlet|#{(plus x) y}|]
    helper "xxy" [hamlet|#{plus (plus x x) y}|]
    let alist = ["1", "2", "3"]
    helper "123" [hamlet|
$forall x <- (id id id id alist)
    #{x}
|]

caseHamletLiterals :: Assertion
caseHamletLiterals = do
    helper "123" [hamlet|#{show 123}|]
    helper "123.456" [hamlet|#{show 123.456}|]
    helper "-123" [hamlet|#{show -123}|]
    helper "-123.456" [hamlet|#{show -123.456}|]

helper' :: String -> Html -> Assertion
helper' res h = T.pack res @=? Text.Blaze.Renderer.Text.renderHtml h

caseHamlet' :: Assertion
caseHamlet' = do
    helper' "foo" [shamlet|foo|]
    helper' "foo" [xshamlet|foo|]
    helper "<br>" $ const $ [shamlet|<br|]
    helper "<br/>" $ const $ [xshamlet|<br|]

    -- new with generalized stuff
    helper' "foo" [shamlet|foo|]
    helper' "foo" [xshamlet|foo|]
    helper "<br>" $ const $ [shamlet|<br|]
    helper "<br/>" $ const $ [xshamlet|<br|]


instance Show Url where
    show _ = "FIXME remove this instance show Url"

caseDiffBindNames :: Assertion
caseDiffBindNames = do
    let list = words "1 2 3"
    -- FIXME helper "123123" $(hamletFileDebug "test/external-debug3.hamlet")
    error "test has been disabled"


caseTrailingSpaces :: Assertion
caseTrailingSpaces = helper "" [hamlet|
$if   True   
$elseif   False   
$else   
$maybe x <-   Nothing    
$nothing  
$forall   x     <-   empty       
|]
  where
    empty = []




data Msg = Hello | Goodbye

ihelper :: String -> HtmlUrlI18n Msg Url -> Assertion
ihelper res h = do
    let x = Text.Blaze.Renderer.Text.renderHtml $ h showMsg render
    T.pack res @=? x
  where
    showMsg Hello = preEscapedString "Hola"
    showMsg Goodbye = preEscapedString "Adios"
