{-# LANGUAGE OverloadedStrings #-}
module Text.Digestive.Form.Encoding.Tests
    ( tests
    ) where

import Control.Applicative ((<$>), (<*>))
import Control.Monad.Identity (Identity (..))

import Data.Text (Text)
import Test.Framework (Test, testGroup)
import Test.Framework.Providers.HUnit (testCase)
import Test.HUnit ((@=?))

import Text.Digestive.Form
import Text.Digestive.Form.Encoding

tests :: Test
tests = testGroup "Text.Digestive.Field.Tests"
    [ testCase "formEncType url-encoded" $
        UrlEncoded @=? formEncType' ((,) <$> text Nothing <*> bool Nothing)
    , testCase "formEncType multipart" $
        MultiPart @=? formEncType' ((,) <$> text Nothing <*> file)
    , testCase "formEncType multipart" $
        MultiPart @=? formEncType' ((,) <$> file <*> bool Nothing)
    ]

  where
    formEncType' :: Form Text Identity a -> FormEncType
    formEncType' = runIdentity . formEncType
