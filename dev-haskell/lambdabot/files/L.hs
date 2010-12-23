{-# LANGUAGE NoMonomorphismRestriction, StandaloneDeriving, UndecidableInstances #-}
module L where
import Prelude hiding ((.),(++),flip)
import Control.Applicative
import Control.Arrow
import Control.Arrow.Operations
import Control.Monad
import Control.Monad.Cont
import Control.Monad.Error
import Control.Monad.Fix
import Control.Monad.Identity
import Control.Monad.Instances
-- import Control.Monad.Logic
import Control.Monad.RWS
import Control.Monad.Reader
import Control.Monad.ST (ST, runST, fixST)
import Control.Monad.State
import Control.Monad.Writer
import Control.Parallel
import Control.Parallel.Strategies
import Data.Array
import Data.Bits
import Data.Bool
import Data.Char
import Data.Complex
import Data.Dynamic
import Data.Either
import Data.Eq
import Data.Fixed
import Data.Function hiding ((.),flip)
import Data.Generics hiding (GT)
import Data.Graph
import Data.Int
import Data.Ix
import Data.List hiding ((++),map)
import Data.Maybe
import Data.Monoid
import Data.Number.BigFloat
import Data.Number.CReal
import Data.Number.Dif
import Data.Number.Interval
import Data.Number.Symbolic
import Data.Ord
import Data.Ratio
import Data.STRef
import Data.Tree
import Data.Tuple
import Data.Typeable
import Data.Word
import Numeric
import ShowQ
import System.Random
import Text.PrettyPrint.HughesPJ hiding (empty)
import Text.Printf
import Text.Regex.Posix
import qualified Control.Arrow.Transformer as AT
import qualified Control.Arrow.Transformer.All as AT
import qualified Data.ByteString as BS
import qualified Data.ByteString.Char8 as BSC
import qualified Data.ByteString.Lazy as BSL
import qualified Data.ByteString.Lazy.Char8 as BSLC
import qualified Data.Foldable
import qualified Data.Generics
import qualified Data.IntMap as IM
import qualified Data.IntSet as IS
import qualified Data.Map as M
import qualified Data.Sequence as Seq
import qualified Data.Set as S
import qualified Data.Traversable
import qualified Data.MemoCombinators as Memo
import ShowIO

import SimpleReflect hiding (var)
import Math.OEIS
import Control.Monad.Random

import Data.VectorSpace hiding (Sum, getSum)
import Data.NumInstances
import Data.LinearMap

-- import qualified Test.IOSpec as IOSpec

import Data.Fixed

(.) :: (Functor f) => (a -> b) -> f a -> f b
(.) = fmap
infixr 9 .

flip :: Functor f => f (a -> b) -> a -> f b
flip f x = fmap ($ x) f

(++) :: (Monoid m) => m -> m -> m
(++) = mappend
infixr 5 ++

asTypeIn :: a -> (a -> b) -> a
a `asTypeIn` f = a where _ = f a
infixl 0 `asTypeIn`

f `asAppliedTo` x = f `asTypeIn` \f -> f x
infixl 0 `asAppliedTo`

describeSequence = fmap description . lookupSequence

newtype Mu f = In (f (Mu f))
out (In x) = x
deriving instance Show (f (Mu f)) => Show (Mu f)

newtype Rec a = InR { outR :: Rec a -> a }

data Bin a = Tip | Branch a (Bin a) (Bin a)
  deriving (Eq, Ord, Show, Read)
-- Fun Stuff

cake = ["One 18.25 ounce package chocolate cake mix.",
        "One can prepared coconut pecan frosting.",
        "Three slash four cup vegetable oil.",
        "Four large eggs.",
        "One cup semi-sweet chocolate chips.",
        "Three slash four cups butter or margarine.",
        "One and two third cups granulated sugar.",
        "Two cups all-purpose flour.",
        "Don't forget garnishes such as:",
        "Fish shaped crackers.",
        "Fish shaped candies.",
        "Fish shaped solid waste.",
        "Fish shaped dirt.",
        "Fish shaped ethylbenzene.",
        "Pull and peel licorice.",
        "Fish shaped organic compounds and sediment shaped sediment.",
        "Candy coated peanut butter pieces. Shaped like fish.",
        "One cup lemon juice.",
        "Alpha resins.",
        "Unsaturated polyester resin.",
        "Fiberglass surface resins.",
        "And volatile malted milk impoundments.",
        "Nine large egg yolks.",
        "Twelve medium geosynthetic membranes.",
        "One cup granulated sugar.",
        "An entry called 'how to kill someone with your bare hands.'",
        "Two cups rhubarb, sliced.",
        "Two slash three cups granulated rhubarb.",
        "One tablespoon all-purpose rhubarb.",
        "One teaspoon grated orange rhubarb.",
        "Three tablespoons rhubarb, on fire.",
        "One large rhubarb.",
        "One cross borehole electro-magnetic imaging rhubarb.",
        "Two tablespoons rhubarb juice.",
        "Adjustable aluminum head positioner.",
        "Slaughter electric needle injector.",
        "Cordless electric needle injector.",
        "Injector needle driver.",
        "Injector needle gun.",
        "Cranial caps.",
        "And it contains proven preservatives, deep penetration agents, and gas and odor control chemicals.",
        "That will deodorize and preserve putrid tissue."]

{-# LINE 1 "<local>" #-}
(****) = (\f n v -> (iterate f v) !! n)
toChurch = ((appEndo . Data.Foldable.foldMap Endo) .) . replicate
fromChuch f = f (+1) 0
evalCont :: Cont o o -> o; evalCont = (`runCont` id)
eq f g = \x -> f x == g (x::[Int])
