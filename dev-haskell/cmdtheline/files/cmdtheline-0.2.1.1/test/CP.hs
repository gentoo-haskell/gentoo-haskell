module CP where
import System.Console.CmdTheLine
import Control.Applicative

import System.Directory ( copyFile
                        , doesDirectoryExist
                        )
import System.FilePath  ( takeFileName
                        , pathSeparator
                        , hasTrailingPathSeparator
                        )

import System.IO
import System.Exit ( exitFailure )

sep :: String
sep = [pathSeparator]

cp :: Bool -> [String] -> String -> IO ()
cp dry sources dest =
  chooseTactic =<< doesDirectoryExist dest
  where
  chooseTactic isDir
    | singleFile = singleCopy $ head sources
    | not isDir  = notDirErr
    | otherwise  = mapM_ copyToDir sources
    where
    singleCopy = if isDir then copyToDir else copyToFile

  singleFile = length sources == 1

  notDirErr = do
    hPutStrLn stderr "cp: DEST is not a directory and SOURCES is of length >1."
    exitFailure

  copyToDir filePath = if dry
    then putStrLn $ concat [ "cp: copying ", filePath, " to ", dest' ]
    else copyFile filePath dest'
    where
    dest'           = withTrailingSep ++ takeFileName filePath
    withTrailingSep =
      if hasTrailingPathSeparator dest then dest else dest ++ sep

  copyToFile filePath = if dry
    then putStrLn $ concat [ "cp: copying ", filePath, " to ", dest ]
    else copyFile filePath dest


-- An example of using the 'rev' and 'Left' variants of 'pos', as well as
-- validating file paths.
term :: Term (IO ())
term = cp <$> dry <*> filesExist sources <*> validPath dest
  where
  dry = value $ flag (optInfo [ "dry", "d" ])
      { optName = "DRY"
      , optDoc  = "Perform a dry run.  Print what would be copied, but do not "
               ++ "copy it."
      }

  sources = nonEmpty $ revPosLeft 0 [] posInfo
          { posName = "SOURCES"
          , posDoc  = "Source file(s) to copy."
          }

  dest    = required $ revPos 0 Nothing posInfo
          { posName = "DEST"
          , posDoc  = "Destination of the copy. Must be a directory if there "
                   ++ "is more than one $(i,SOURCE)."
          }

termInfo :: TermInfo
termInfo = defTI
  { termName = "cp"
  , version  = "v1.0"
  , termDoc  = "Copy files from SOURCES to DEST."
  , man      = [ S "BUGS"
               , P "Email bug reports to <portManTwo@example.com>"
               ]
  }
