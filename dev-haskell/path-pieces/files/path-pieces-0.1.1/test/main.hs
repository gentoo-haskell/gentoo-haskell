{-# Language ScopedTypeVariables #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
module Main where

import Test.Hspec.Monadic (Specs, describe, hspecX)
import Test.Hspec.HUnit()
import Test.Hspec.QuickCheck(prop)
import Test.QuickCheck

import Web.PathPieces
import qualified Data.Text as T
import Data.Maybe (fromJust)

-- import FileLocation (debug)

instance Arbitrary T.Text where
  arbitrary = fmap T.pack arbitrary


main :: IO ()
main = hspecX specs

specs :: Specs
specs = do
  describe "RoutePiece" $ do
    prop "toRoutePiece <=> fromSinglePiece String" $ \(p::String) ->
      case (fromRoutePiece . toSinglePiece) p of
        Nothing -> null p
        Just pConverted -> p == pConverted

    prop "toRoutePiece <=> fromSinglePiece String" $ \(p::T.Text) ->
      case (fromRoutePiece . toSinglePiece) p of
        Nothing -> T.null p
        Just pConverted -> p == pConverted

    prop "toRoutePiece <=> fromSinglePiece String" $ \(p::Int) ->
      case (fromRoutePiece . toSinglePiece) p of
        Nothing -> p < 0
        Just pConverted -> p == pConverted

  describe "RouteMultiPiece" $ do
    prop "toRouteMultiPiece <=> fromMultiPiece String" $ \(p::[String]) ->
      p == (fromJust . fromRouteMultiPiece . toMultiPiece) p

    prop "toRouteMultiPiece <=> fromMultiPiece String" $ \(p::[T.Text]) ->
      p == (fromJust . fromRouteMultiPiece . toMultiPiece) p


  describe "SinglePiece" $ do
    prop "toSinglePiece <=> fromSinglePiece String" $ \(p::String) ->
      case (fromSinglePiece . toSinglePiece) p of
        Nothing -> null p
        Just pConverted -> p == pConverted

    prop "toSinglePiece <=> fromSinglePiece String" $ \(p::T.Text) ->
      case (fromSinglePiece . toSinglePiece) p of
        Nothing -> T.null p
        Just pConverted -> p == pConverted

    prop "toSinglePiece <=> fromSinglePiece String" $ \(p::Int) ->
      case (fromSinglePiece . toSinglePiece) p of
        Nothing -> p < 0
        Just pConverted -> p == pConverted

  describe "MultiPiece" $ do
    prop "toMultiPiece <=> fromMultiPiece String" $ \(p::[String]) ->
      p == (fromJust . fromMultiPiece . toMultiPiece) p

    prop "toMultiPiece <=> fromMultiPiece String" $ \(p::[T.Text]) ->
      p == (fromJust . fromMultiPiece . toMultiPiece) p
