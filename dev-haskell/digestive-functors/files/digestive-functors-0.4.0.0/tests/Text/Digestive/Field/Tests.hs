{-# LANGUAGE OverloadedStrings #-}
module Text.Digestive.Field.Tests
    ( tests
    ) where

import Test.Framework (Test, testGroup)
import Test.Framework.Providers.HUnit (testCase)
import Test.HUnit ((@=?))

import Text.Digestive.Field
import Text.Digestive.Types

tests :: Test
tests = testGroup "Text.Digestive.Field.Tests"
    [ testCase "evalField singleton" $
        9160 @=? evalField undefined undefined (Singleton (9160 :: Int))

    , testCase "evalField bool post without input" $
        False @=? evalField Post [] (Bool True)

    , testCase "evalField bool post strange input" $
        False @=? evalField Post [TextInput "herp"] (Bool True)

    , testCase "evalField bool post correct input" $
        True @=? evalField Post [TextInput "on"] (Bool True)

    , testCase "evalField bool get" $
        True @=? evalField Get [] (Bool True)
    ]
