module Notify (testNotify) where

import Common

import Control.Applicative
import Control.Concurrent
import Control.Monad
import Data.Function
import Data.List
import Database.PostgreSQL.Simple.Notification

import qualified Data.ByteString as B

-- TODO: Test with payload, but only for PostgreSQL >= 9.0
-- (when that feature was introduced).

testNotify :: TestEnv -> Test
testNotify TestEnv{..} =
    TestCase $
    withConn $ \conn2 -> do
        execute_ conn "LISTEN foo"
        execute_ conn "LISTEN bar"

        results_mv <- newEmptyMVar
        forkIO $ replicateM 2 (getNotification conn)
             >>= putMVar results_mv

        threadDelay 100000

        execute_ conn2 "NOTIFY foo"
        execute_ conn2 "NOTIFY bar"

        [n1, n2] <- sortBy (compare `on` notificationChannel)
                <$> takeMVar results_mv

        assertEqual "n1" "bar" (notificationChannel n1)
        assertEqual "n2" "foo" (notificationChannel n2)

        -- Other sanity checks
        assertEqual "Server PIDs match" (notificationPid n1) (notificationPid n2)
        assertBool "notificationData is empty" $
            all (B.null . notificationData) [n1, n2]
