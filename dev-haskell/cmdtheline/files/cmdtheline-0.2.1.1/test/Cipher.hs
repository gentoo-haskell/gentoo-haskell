module Cipher where
import System.Console.CmdTheLine
import Control.Applicative

import Data.Char ( isUpper, isAlpha, isAlphaNum, isSpace
                 , toLower
                 )
import Data.List ( intersperse )

import System.IO
import System.Exit

infixr 2 <||>
-- Split a value between predicates and 'or' the results together
(<||>) :: (a -> Bool) -> (a -> Bool) -> (a -> Bool)
p <||> p' = (||) <$> p <*> p'


--
-- Rot
--

data Cycle a = Cycle
  { backward :: (Cycle a)
  , at       :: a
  , forward  :: (Cycle a)
  }

fromList :: [a] -> Cycle a
fromList [] = error "Cycle must have at least one element"
fromList xs = first
  where
  ( first, last ) = go last xs first

  go :: Cycle a -> [a] -> Cycle a -> ( Cycle a, Cycle a )
  go prev []       next = ( next, prev )
  go prev (x : xs) next = ( this, last )
    where
    this        = Cycle prev x rest
    (rest,last) = go this xs next

-- Return a Cycle centered on x.
seekTo :: Eq a => a -> Cycle a -> Cycle a
seekTo x xs
  | x == at xs = xs
  | otherwise  = seekTo x $ forward xs
 
-- Seek n places forwards or backwards.
seek :: Bool -> Int -> Cycle a -> Cycle a
seek _    0 xs = xs
seek back n xs = seek back (n - 1) (dir xs)
  where
  dir = if back then backward else forward

lowers, uppers :: Cycle Char
lowers = fromList ['a'..'z']
uppers = fromList ['A'..'Z']

rot :: Bool -> Int -> Maybe String -> IO ()
rot back n mStr = do
  input <- case mStr of
    Nothing  -> getContents
    Just str -> return str

  putStrLn $ map rotChar input
  where
  rotChar c = if isAlpha c then c' else c
    where
    c'    = at . seek back n $ seekTo c cycle
    cycle = if isUpper c then uppers else lowers


--
-- Morse
--

switch :: ( a, b ) -> ( b, a )
switch ( x, y ) = ( y, x )

fromCode :: [( String, Char )]
fromCode = map switch toCode

toCode :: [( Char, String )]
toCode =
  [ ( 'a', ".-"    ), ( 'b', "-..."  ), ( 'c', "-.-."  ), ( 'd', "-.."   )
  , ( 'e', "."     ), ( 'f', "..-."  ), ( 'g', "--."   ), ( 'h', "...."  )
  , ( 'i', ".."    ), ( 'j', ".---"  ), ( 'k', "-.-"   ), ( 'l', ".-.."  )
  , ( 'm', "--"    ), ( 'n', "-."    ), ( 'o', "---"   ), ( 'p', ".--."  )
  , ( 'q', "--.-"  ), ( 'r', ".-."   ), ( 's', "..."   ), ( 't', "-"     )
  , ( 'u', "..-"   ), ( 'v', "...-"  ), ( 'w', ".--"   ), ( 'x', "-..-"  )
  , ( 'y', "-.--"  ), ( 'z', "--.."  ), ( '1', ".----" ), ( '2', "..---" )
  , ( '3', "...--" ), ( '4', "....-" ), ( '5', "....." ), ( '6', "-...." )
  , ( '7', "--..." ), ( '8', "---.." ), ( '9', "----." ), ( '0', "-----" )
  , ( ' ', "/"     )
  ]

fromMorse, toMorse :: [String] -> Maybe String
fromMorse    = mapM (`lookup` fromCode)
toMorse strs = sepCat " / " <$> mapM convertLetters strs
  where
  convertLetters chars = sepCat " " <$> mapM (`lookup` toCode) chars

  sepCat sep = concat . intersperse sep

morse :: Bool -> Maybe String -> IO ()
morse from mStr = do
  input <- case mStr of
    Nothing  -> getContents
    Just str -> return str

  if all pred input
     then return ()
     else do hPutStrLn stderr err
             exitFailure

  convert input
  where
  pred = if from then (== '/') <||> (== '-') <||> (== '.') <||> isSpace
                 else isAlphaNum <||> isSpace

  err = if from
    then "cipher: morse input must be all spaces, '/'s, '-'s, and '.'s."
    else "cipher: morse input must be alphanumeric and/or spaces"

  convert str = maybe badConvert putStrLn . convert' . words $ map toLower str
    where
    badConvert = hPutStrLn stderr err >> exitFailure
      where
      err = if from then "cipher: could not convert from morse"
                    else "cipher: could not convert to morse"

    convert' = if from then fromMorse else toMorse


--
-- Terms
--

-- The heading under which to place common options.
comOpts :: String
comOpts = "COMMON OPTIONS"

-- A modified default 'TermInfo' to be shared by commands.
defTI' :: TermInfo
defTI' = defTI
  { man =
      [ S comOpts
      , P "These options are common to all commands."
      , S "MORE HELP"
      , P "Use '$(mname) $(i,COMMAND) --help' for help on a single command."
      , S "BUGS"
      , P "Email bug reports to <snideHighland@example.com>"
      ]
  , stdOptSec = comOpts
  }

-- 'input' is a common option. We set its 'optSec' field to 'comOpts' so
-- that it is placed under that section instead of the default '"OPTIONS"'
-- section, which we will reserve for command-specific options.
input :: Term (Maybe String)
input = value $ opt Nothing (optInfo [ "input", "i" ])
      { optName = "INPUT"
      , optDoc  = "For specifying input on the command line.  If present, "
               ++ "input is not read form standard-in."
      , optSec  = comOpts
      }

rotTerm :: ( Term (IO ()), TermInfo )
rotTerm = ( rot <$> back <*> n <*> input, termInfo )
  where
  back = value $ flag (optInfo [ "back", "b" ])
       { optName = "BACK"
       , optDoc  = "Rotate backwards instead of forwards."
       }

  n    = value $ opt 13 (optInfo [ "n" ])
       { optName = "N"
       , optDoc  = "How many places to rotate by."
       }

  termInfo = defTI'
    { termName = "rot"
    , termDoc  = "Rotate the input characters by N."
    , man      = [ S "DESCRIPTION"
                 , P $ "Rotate input gathered from INPUT or standard-in N "
                    ++ "places.  The input must be composed totally of "
                    ++ "alphabetic characters and spaces."
                 ] ++ man defTI'
    }

morseTerm :: ( Term (IO ()), TermInfo )
morseTerm = ( morse <$> from <*> input, termInfo )
  where
  from = value $ flag (optInfo [ "from", "f" ])
       { optName   = "FROM"
       , optDoc    = "Convert from morse-code to the Latin alphabet. "
                  ++ "If absent, convert from Latin alphabet to morse-code."
       }

  termInfo = defTI'
    { termName = "morse"
    , termDoc  = "Convert to and from morse-code."
    , man      = [ S "DESCRIPTION"
                 , P desc
                 ] ++ man defTI'
    }

  desc = concat
    [ "Converts input gathered from INPUT or standard in to and from morse "
    , "code. 'dah' is represented by '-', 'dit' by '.'.  Each morse character "
    , "is separated from the next by one or more ' '.  Morse words are "
    , "separated by a '/'."
    ]


defaultTerm :: ( Term a, TermInfo )
defaultTerm = ( ret $ const (helpFail Pager Nothing) <$> input
              , termInfo
              )
  where
  termInfo = defTI'
    { termName      = "cipher"
    , version       = "v1.0"
    , termDoc       = doc
    }

  doc = "An implementation of the morse-code and rotational(Caesar) ciphers."
