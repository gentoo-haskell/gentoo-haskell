module ShakespeareBaseTest (specs) where

import Test.HUnit hiding (Test)
import Test.Hspec.Monadic
import Test.Hspec.HUnit ()

import Text.ParserCombinators.Parsec (parse, ParseError, (<|>))
import Text.Shakespeare.Base (parseVarString, parseUrlString, parseIntString)
import Text.Shakespeare (preFilter, defaultShakespeareSettings, ShakespeareSettings(..), PreConvert(..), PreConversion(..))

-- run :: Text.Parsec.Prim.Parsec Text.Parsec.Pos.SourceName () c -> Text.Parsec.Pos.SourceName -> c

specs :: Specs
specs = describe "shakespeare-js" $ do
  it "parseStrings" $ do
    Right "%{var}" @=?  run varString "%{var}"
    Right "@{url}" @=?  run urlString "@{url}"
    Right "^{int}" @=?  run intString "^{int}"
    Right "@{url}" @=?  run (varString <|> urlString <|> intString) "@{url} #{var}"

  it "preFilter off" $ do
    str <- preFilter defaultShakespeareSettings template
    str @=? template

  it "preFilter on" $ do
    str <- preFilter preConversionSettings template
    "unchanged `#{var}` `@{url}` `^{int}`" @=? str

  it "preFilter ignore quotes" $ do
    str <- preFilter preConversionSettings templateQuote
    "unchanged '#{var}' `@{url}` '^{int}'" @=? str

  it "preFilter ignore comments" $ do
    str <- preFilter preConversionSettings templateCommented
    "unchanged & '#{var}' @{url} '^{int}'" @=? str

  where
    varString = parseVarString '%'
    urlString = parseUrlString '@' '?'
    intString = parseIntString '^'

    preConversionSettings = defaultShakespeareSettings {
      preConversion = Just PreConvert {
          preConvert = Id
        , preEscapeBegin = "`"
        , preEscapeEnd = "`"
        , preEscapeIgnoreBalanced = "'\""
        , preEscapeIgnoreLine = "&"
        }
    }
    template  = "unchanged #{var} @{url} ^{int}"
    templateQuote = "unchanged '#{var}' @{url} '^{int}'"
    templateCommented = "unchanged & '#{var}' @{url} '^{int}'"

    run parser str = eShowErrors $ parse parser str str

    eShowErrors :: Either ParseError c -> c
    eShowErrors = either (error . show) id

