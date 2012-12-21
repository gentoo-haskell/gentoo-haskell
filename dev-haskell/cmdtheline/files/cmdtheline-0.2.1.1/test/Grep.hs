module Grep where
import System.Console.CmdTheLine
import Control.Applicative

import Data.List ( intersperse )

import System.Cmd  ( system )
import System.Exit ( exitWith )

grep :: String -> [String] -> IO ()
grep pattern dests = do
  exitWith =<< system (concat . intersperse " " $ [ "grep", pattern ] ++ dests)

-- An example of using the 'pos' and 'posRight' Terms.
term = grep <$> pattern <*> files
  where
  pattern  = required $ pos 0 Nothing posInfo { posName = "PATTERN" }
  files    = value    $ posRight 0 [] posInfo { posName = "FILE"    }

termInfo = defTI
  { termName = "grep"
  , version  = "2.5"
  , termDoc  = "Search for PATTERN in FILE(s) or standard in."
  , man      =
    [ S "BUGS"
    , P "Please send bug reports to <throatWobblerMangrove@example.com>"
    ]
  }
