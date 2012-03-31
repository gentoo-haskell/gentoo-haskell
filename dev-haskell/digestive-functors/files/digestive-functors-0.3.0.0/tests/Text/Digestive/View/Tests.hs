{-# LANGUAGE OverloadedStrings #-}
module Text.Digestive.View.Tests
    ( tests
    ) where

import Data.Text (Text)
import Test.Framework (Test, testGroup)
import Test.Framework.Providers.HUnit (testCase)
import Test.HUnit ((@=?))

import Text.Digestive.Tests.Fixtures
import Text.Digestive.Types
import Text.Digestive.View

tests :: Test
tests = testGroup "Text.Digestive.View.Tests"
    [ testCase "Simple postForm" $ (@=?)
        (Just (Pokemon "charmander" 5 Fire False)) $
        snd $ runTrainerM $ postForm "f" pokemonForm $ testEnv
            [ ("f.name",  "charmander")
            , ("f.level", "5")
            , ("f.type",  "type.1")
            ]

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
        (Just (Catch (Pokemon "charmander" 5 Fire False) Ultra)) $
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
    ]

testEnv :: Monad m => [(Text, Text)] -> Env m
testEnv input key = return $ map (TextInput . snd) $
    filter ((== fromPath key) . fst) input
