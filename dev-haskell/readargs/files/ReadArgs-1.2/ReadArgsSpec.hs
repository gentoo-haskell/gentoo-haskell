{-# LANGUAGE ScopedTypeVariables #-}
module Main where

import Test.Hspec
import ReadArgs
import Data.Text (pack)
import Filesystem.Path.CurrentOS (fromText)

spec :: Spec
spec = 
  describe "parseArgsFrom" $ do
    it "can parse zero arguments" $
      parseArgsFrom [] `shouldBe` Just ()
    
    it "can parse a single argument" $
      parseArgsFrom ["3"] `shouldBe` Just ((3 :: Int) :& ())
    
    it "can parse a pair of arguments" $
      parseArgsFrom ["3", "4"] `shouldBe` Just (3 :: Int, 4 :: Int)
    
    it "can parse a string without double quotes" $
      parseArgsFrom ["abe", "bar"] `shouldBe` Just ("abe", "bar")
    
    it "can parse text without double quotes" $
      parseArgsFrom ["abe", "bar"] `shouldBe` Just (pack "abe", pack "bar")
    
    it "can parse a filepath  without double quotes" $
      parseArgsFrom ["abe", "bar"] `shouldBe` Just (fromText $ pack "abe", fromText $ pack "bar")
    
    it "can parse a character without single quotes" $
      parseArgsFrom ["a", "b"] `shouldBe` Just ('a','b')
    
    it "can parse a triplet of arguments" $
      parseArgsFrom ["3", "steve", "1.0"] `shouldBe` Just (3 :: Int, "steve", 1.0 :: Float)
    
    it "can parse an optional argument at the end" $ do
      parseArgsFrom ["3", "steve", "1.0"] `shouldBe` Just (3 :: Int, "steve", Just 1.0 :: Maybe Float)
      parseArgsFrom ["3", "steve"] `shouldBe` Just (3 :: Int, "steve", Nothing :: Maybe Float)
    
    it "can parse an optional argument in the middle" $ do
      parseArgsFrom ["3", "steve", "1.0"] `shouldBe` Just (3 :: Int, Just "steve", 1.0 :: Float)
      parseArgsFrom ["3", "1.0"] `shouldBe` Just (3 :: Int, Nothing :: Maybe String, 1.0 :: Float)
    
    it "can parse an optional argument at the front" $ do
      parseArgsFrom ["3", "steve", "1.0"] `shouldBe` Just (Just 3 :: Maybe Int, "steve", 1.0 :: Float)
      parseArgsFrom ["steve", "1.0"] `shouldBe` Just (Nothing:: Maybe Int, "steve", 1.0 :: Float)
    
    it "can parse optional arguments greedily" $
      parseArgsFrom ["a", "b"] `shouldBe` Just (Just "a", Just "b", Nothing :: Maybe String)
    
    it "can parse optional arguments non-greedily" $ do
      parseArgsFrom ["a", "b"] `shouldBe` Just (Just "a", NonGreedy Nothing :: NonGreedy Maybe String, Just "b")
      parseArgsFrom ["a", "b"] `shouldBe` Just (NonGreedy Nothing :: NonGreedy Maybe String, Just "a", Just "b")
    
    it "can parse a variable number of arguments at the end" $ do
      parseArgsFrom ["3", "steve"] `shouldBe` Just (3 :: Int, "steve", [] :: [Float])
      parseArgsFrom ["3", "steve", "1.0"] `shouldBe` Just (3 :: Int, "steve", [1.0] :: [Float])
      parseArgsFrom ["3", "steve", "1.0", "2.0", "3.0"] `shouldBe` Just (3 :: Int, "steve", [1,2,3] :: [Float])
    
    it "can parse a variable number of arguments in the middle" $ do
      parseArgsFrom ["3", "1.0"] `shouldBe` Just (3 :: Int, [] :: [String], 1.0 :: Float)
      parseArgsFrom ["3", "a", "1.0"] `shouldBe` Just (3 :: Int, ["a"], 1.0 :: Float)
      parseArgsFrom ["3", "a", "b", "c", "1.0"] `shouldBe` Just (3 :: Int, ["a","b","c"], 1.0 :: Float)
    
    it "can parse a variable number of arguments at the front" $ do
      parseArgsFrom ["steve", "1.0"] `shouldBe` Just ([] :: [Int], "steve", 1.0 :: Float)
      parseArgsFrom ["1", "steve", "1.0"] `shouldBe` Just ([1] :: [Int], "steve", 1.0 :: Float)
      parseArgsFrom ["1", "2", "3", "steve", "1.0"] `shouldBe` Just ([1,2,3] :: [Int], "steve", 1.0 :: Float)
    
    it "can parse variable arguments greedily" $
      parseArgsFrom ["1", "2"] `shouldBe` Just ([1,2] :: [Int], [] :: [Int], [] :: [Int])
    
    it "can parse variable arguments non-greedily" $ do
      parseArgsFrom ["1", "2"] `shouldBe` Just (NonGreedy [] :: NonGreedy [] Int, [1,2] :: [Int], [] :: [Int])
      parseArgsFrom ["1", "2"] `shouldBe` Just (NonGreedy [] :: NonGreedy [] Int, NonGreedy [] :: NonGreedy [] Int, [1,2] :: [Int])
    
    it "can parse adjacent sets of variable arguments" $
      parseArgsFrom ["1", "2", "a", "b"] `shouldBe` Just ([1,2] :: [Int], ["a","b"] :: [String])
    
    it "can parse a single argument without tuples" $
      parseArgsFrom ["3"] `shouldBe` Just (3 :: Int)
    
    it "can parse an optional argument without tuples" $ do
      parseArgsFrom ["3"] `shouldBe` Just (Just 3 :: Maybe Int)
      parseArgsFrom [] `shouldBe` Just (Nothing :: Maybe Int)
    
    it "can parse a variable argument without tuples" $ do
      parseArgsFrom ["1","2","3"] `shouldBe` Just ([1,2,3] :: [Int])
      parseArgsFrom [] `shouldBe` Just ([] :: [Int])
    
   

main :: IO ()
main = hspec spec
