module Hello where
import System.Console.CmdTheLine
import Control.Applicative

import Control.Monad ( when )

-- Define a flag argument under the names '--silent' and '-s'
silent :: Term Bool
silent = value . flag $ optInfo [ "silent", "s" ]

-- Define the 0th positional argument, defaulting to the value '"world"' in
-- absence.
greeted :: Term String
greeted = value $ pos 0 "world" posInfo { posName = "GREETED" }

hello :: Bool -> String -> IO ()
hello silent str = when (not silent) . putStrLn $ "Hello, " ++ str ++ "!"

term :: Term (IO ())
term = hello <$> silent <*> greeted

termInfo :: TermInfo
termInfo = defTI { termName = "Hello", version = "1.0" }
