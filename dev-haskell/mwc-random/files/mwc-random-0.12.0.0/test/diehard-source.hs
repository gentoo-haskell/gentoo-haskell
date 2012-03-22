-- Enthropy source for dieharder tests.
-- See run-dieharder-test.sh for details
import Control.Monad           (forever)
import Data.Word               (Word32)
import System.IO               (hPutBuf,stdout)
import Foreign.Marshal.Alloc   (alloca)
import Foreign.Storable        (poke)

import System.Random.MWC

main :: IO ()
main =
  withSystemRandom $ \gen -> forever $ do
    alloca $ \p -> do
      poke p =<< (uniform gen :: IO Word32)
      hPutBuf stdout p 4
