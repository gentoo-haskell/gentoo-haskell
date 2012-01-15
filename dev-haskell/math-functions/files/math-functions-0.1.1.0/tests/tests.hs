import Test.Framework       (defaultMain)
import qualified Tests.SpecFunctions
import qualified Tests.Chebyshev

main :: IO ()
main = defaultMain [ Tests.SpecFunctions.tests
                   , Tests.Chebyshev.tests
                   ]
