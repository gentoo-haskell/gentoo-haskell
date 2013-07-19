{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE ExistentialQuantification #-}
{-# LANGUAGE NamedFieldPuns #-}
{-# LANGUAGE CPP #-}

module Control.Monad.Catch.Tests (tests) where

#if defined(__GLASGOW_HASKELL__) && (__GLASGOW_HASKELL__ < 706)
import Prelude hiding (catch)
#endif

import Control.Applicative ((<*>))
import Data.Data (Data, Typeable)

import Control.Monad.Trans.Identity (IdentityT(..))
import Control.Monad.Reader (ReaderT(..))
import Test.Framework (Test, testGroup)
import Test.Framework.Providers.QuickCheck2 (testProperty)
import Test.QuickCheck (Property, once)
import Test.QuickCheck.Monadic (monadic, run, assert)
import Test.QuickCheck.Property (morallyDubiousIOProperty)
import qualified Control.Monad.State.Lazy as LazyState
import qualified Control.Monad.State.Strict as StrictState
import qualified Control.Monad.Writer.Lazy as LazyWriter
import qualified Control.Monad.Writer.Strict as StrictWriter
import qualified Control.Monad.RWS.Lazy as LazyRWS
import qualified Control.Monad.RWS.Strict as StrictRWS

import Control.Monad.Catch (Exception, MonadCatch(..), runCatch,
                            catchJust)

data TestException = TestException String
    deriving (Show, Eq, Data, Typeable)

instance Exception TestException

data MSpec = forall m. (MonadCatch m) => MSpec
    { mspecName :: String
    , mspecRunner :: (m Property -> Property)
    }

testMonadCatch :: MSpec -> Property
testMonadCatch MSpec { mspecRunner } = monadic mspecRunner $
    run $ catch failure handler
  where
    failure = throwM (TestException "foo") >> error "testMonadCatch"
    handler (_ :: TestException) = return ()

testCatchJust :: MSpec -> Property
testCatchJust MSpec { mspecRunner } = monadic mspecRunner $ do
    nice <- run $ catchJust testException posFailure posHandler
    assert $ nice == ("pos", True)
    bad <- run $ catch (catchJust testException negFailure posHandler) negHandler
    assert $ bad == ("neg", True)
  where
    testException (TestException s) = if s == "pos" then Just True else Nothing
    posHandler x = return ("pos", x)
    negHandler (_ :: TestException) = return ("neg", True)
    posFailure = throwM (TestException "pos") >> error "testCatchJust pos"
    negFailure = throwM (TestException "neg") >> error "testCatchJust neg"

tests :: Test
tests = testGroup "Control.Monad.Catch.Tests" $
    [ mkMonadCatch
    , mkCatchJust
    ] <*> mspecs
  where
    mspecs =
        [ MSpec "IO" io
        , MSpec "IdentityT IO" $ io . runIdentityT
        , MSpec "LazyState.StateT IO" $ io . flip LazyState.evalStateT ()
        , MSpec "StrictState.StateT IO" $ io . flip StrictState.evalStateT ()
        , MSpec "ReaderT IO" $ io . flip runReaderT ()
        , MSpec "LazyWriter.WriterT IO" $ io . fmap tfst . LazyWriter.runWriterT
        , MSpec "StrictWriter.WriterT IO" $ io . fmap tfst . StrictWriter.runWriterT
        , MSpec "LazyRWS.RWST IO" $ \m -> io $ fmap tfst $ LazyRWS.evalRWST m () ()
        , MSpec "StrictRWS.RWST IO" $ \m -> io $ fmap tfst $ StrictRWS.evalRWST m () ()

        , MSpec "CatchT Indentity" $ fromRight . runCatch
        ]

    tfst :: (Property, ()) -> Property = fst
    fromRight (Left _) = error "fromRight"
    fromRight (Right a) = a
    io = morallyDubiousIOProperty

    mkMonadCatch = mkTestType "MonadCatch" testMonadCatch
    mkCatchJust = mkTestType "catchJust" testCatchJust

    mkTestType name test = \spec ->
        testProperty (name ++ " " ++ mspecName spec) $ once $ test spec
