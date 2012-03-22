import Test.Framework       (defaultMain)
import System.Random.MWC    (withSystemRandom)

import qualified QC
import qualified ChiSquare
import qualified KS


main :: IO ()
main = 
  withSystemRandom $ \g -> 
    defaultMain
    [ QC.tests      g
    , ChiSquare.tests g
    , KS.tests      g
    ]
