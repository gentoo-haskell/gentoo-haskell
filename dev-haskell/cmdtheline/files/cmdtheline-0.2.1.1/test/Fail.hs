module Fail where
import System.Console.CmdTheLine
import Control.Applicative

import Text.PrettyPrint ( fsep   -- Paragraph fill a list of 'Doc'.
                        , text   -- Make a 'String' into a 'Doc'.
                        , quotes -- Quote a 'Doc'.
                        , (<+>)  -- Glue two 'Doc' together with a space.
                        )

import Data.List ( intersperse )


cmdNames = [ "msg", "usage", "help", "success" ]

failMsg, failUsage, success :: [String] -> Err String
failMsg   strs = msgFail   . fsep $ map text strs
failUsage strs = usageFail . fsep $ map text strs
success   strs = return . concat $ intersperse " " strs

help :: String -> Err String
help name
  | any (== name) cmdNames = helpFail Pager $ Just name
  | name == ""             = helpFail Pager Nothing
  | otherwise              =
    usageFail $ quotes (text name) <+> text "is not the name of a command"

noCmd :: Err String
noCmd = helpFail Pager Nothing


def' = defTI
  { stdOptSec = "COMMON OPTIONS"
  , man =
      [ S "COMMON OPTIONS"
      , P "These options are common to all commands."
      , S "MORE HELP"
      , P "Use '$(mname) $(i,COMMAND) --help' for help on a single command."
      , S "BUGS"
      , P "Email bug reports to <dogWalter@example.com>"
      ]
  }

input :: Term [String]
input = nonEmpty $ posAny [] posInfo
      { posName = "INPUT"
      , posDoc  = "Some input you would like printed to the screen on failure "
               ++ "or success."
      }

cmds :: [( Term String, TermInfo )]
cmds =
  [ ( ret $ failMsg <$> input
    , def' { termName = "msg"
           , termDoc  = "Print a failure message."
           }
    )

  , ( ret $ failUsage <$> input
    , def' { termName = "usage"
           , termDoc  = "Print a usage message."
           }
    )

  , ( ret $ success <$> input
    , def' { termName = "success"
           , termDoc  = "Print a message to the screen"
           }
    )

  , ( ret $ help <$> value (pos 0 "" posInfo { posName = "TERM" })
    , def' { termName = "help"
           , termDoc  = "Display help for a command."
           }
    )
  ]

noCmdTerm = ( ret $ pure noCmd
            , def' { termName = "fail"
                   , termDoc  = "A program demoing CmdTheLine's user "
                             ++ "error functionality."
                   }
            )
