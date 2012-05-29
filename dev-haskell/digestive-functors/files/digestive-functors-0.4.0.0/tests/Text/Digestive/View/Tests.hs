{-# LANGUAGE OverloadedStrings, ScopedTypeVariables #-}
module Text.Digestive.View.Tests
    ( tests
    ) where

import Control.Monad.Identity (runIdentity)
import Control.Exception (SomeException, handle)

import Data.Text (Text)
import Test.Framework (Test, testGroup)
import Test.Framework.Providers.HUnit (testCase)
import Test.HUnit (Assertion, assert, assertFailure, (@=?))

import Text.Digestive.Tests.Fixtures
import Text.Digestive.Types
import Text.Digestive.View

assertError :: Show a => a -> Assertion
assertError x = handle (\(_ :: SomeException) -> assert True) $
    x `seq` assertFailure $ "Should throw an error but gave: " ++ show x

tests :: Test
tests = testGroup "Text.Digestive.View.Tests"
    [ testCase "Simple postForm" $ (@=?)
        (Just (Pokemon "charmander" (Just 5) Fire False)) $
        snd $ runTrainerM $ postForm "f" pokemonForm $ testEnv
            [ ("f.name",  "charmander")
            , ("f.level", "5")
            , ("f.type",  "type.1")
            ]

    , testCase "optional unspecified" $ (@=?)
        (Just (Pokemon "magmar" Nothing Fire False)) $
        snd $ runTrainerM $ postForm "f" pokemonForm $ testEnv
            [ ("f.name",  "magmar")
            , ("f.type",  "type.1")
            ]

    , testCase "stringRead float" $ (@=?)
        (Just 4.323 :: Maybe Float) $
        snd $ runIdentity $ postForm "f" floatForm $ testEnv
            [("f.f", "4.323")]

    , testCase "Failing checkM" $ (@=?)
        ["This pokemon will not obey you!"] $
        childErrors "" $ fst $ runTrainerM $ postForm "f" pokemonForm $ testEnv
            [ ("f.name",  "charmander")
            , ("f.level", "9000")
            , ("f.type",  "type.1")
            ]

    , testCase "Failing validate" $ (@=?)
        ["dog is not a pokemon!"] $
        childErrors "" $ fst $ runTrainerM $ postForm "f" pokemonForm $ testEnv
            [("f.name", "dog")]

    , testCase "Simple fieldInputChoice" $ (@=?)
        2 $
        snd $ fieldInputChoice "type" $ fst $ runTrainerM $
            postForm "f" pokemonForm $ testEnv [("f.type",  "type.2")]

    , testCase "Nested postForm" $ (@=?)
        (Just (Catch (Pokemon "charmander" (Just 5) Fire False) Ultra)) $
        snd $ runTrainerM $ postForm "f" catchForm $ testEnv
            [ ("f.pokemon.name",  "charmander")
            , ("f.pokemon.level", "5")
            , ("f.pokemon.type",  "type.1")
            , ("f.ball",          "ball.2")
            ]

    , testCase "subView errors" $ (@=?)
        ["Cannot parse level"] $
        errors "level" $ subView "pokemon" $ fst $ runTrainerM $
            postForm "f" catchForm $ testEnv [("f.pokemon.level", "hah.")]

    , testCase "subView input" $ (@=?)
        2 $
        snd $ fieldInputChoice "type" $ subView "pokemon" $ fst $
            runTrainerM $ postForm "f" catchForm $ testEnv
                [ ("f.pokemon.level", "hah.")
                , ("f.pokemon.type",  "type.2")
                ]

    -- , testCase "subViews length" $ (@=?)
    --     4 $
    --     length $ subViews $ runTrainerM $ getForm "f" pokemonForm

    , testCase "Abusing Choice as Text" $ assertError $
        fieldInputText "type" $ runTrainerM $ getForm "f" pokemonForm

    , testCase "Abusing Bool as Choice" $ assertError $
        fieldInputChoice "rare" $ runTrainerM $ getForm "f" pokemonForm

    , testCase "Abusing Text as Bool" $ assertError $
        fieldInputBool "name" $ runTrainerM $ getForm "f" pokemonForm
    ]

testEnv :: Monad m => [(Text, Text)] -> Env m
testEnv input key = return $ map (TextInput . snd) $
    filter ((== fromPath key) . fst) input
