s/import Monad/import Control.Monad/g
s/import List/import Data.List/g
s/import Maybe/import Data.Maybe/g
s/import Char/import Data.Char/g
s/import Directory/import System.Directory/g
s/import IO$/import System.IO/g
s/import Ratio/import Data.Ratio/g
s/import Time/import System.Time/g
s/^import System$/import System.Environment\nimport System.Exit/g
s/^> import System$/> import System.Environment\n> import System.Exit/g
