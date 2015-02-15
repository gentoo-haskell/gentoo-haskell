{-# LANGUAGE ViewPatterns #-}
{-
  Lambdaman, repomanish verification for gentoo-haskell

  BSD3
  
  Lennart Kolmodin 2009-2011 <kolmodin@gentoo.org>
-}

module Main (main) where

import qualified Control.Monad as M
import qualified Data.List as L
import qualified System.Directory as SD
import qualified System.Posix.Files as SPF

import System.FilePath ((</>))

-- returns (added cats, removed cats)
cats_status :: FilePath -> IO ([FilePath], [FilePath])
cats_status cats_file =
    do -- check for 'categories' consistency
       let banlist = [ "."
                     , ".."
                     , ".git"
                     , ".hackport"
                     , "eclass"
                     , "profiles"
                     , "projects"
                     , "metadata"
                     ]

       known_cats <- readFile cats_file >>= return . lines
       found_cats <- do entries <- SD.getDirectoryContents "."
                        dirs    <- M.filterM ((SPF.isDirectory `fmap`) . SPF.getFileStatus) entries
                        return $ filter (`notElem` banlist) dirs

       return ( known_cats L.\\ found_cats
              , found_cats L.\\ known_cats
              )

main :: IO ()
main = do
  putStrLn "lambdaman scours the neighborhood..."

  (gone_cats, new_cats) <- cats_status ("profiles" </> "categories")

  mapM_ (putStrLn . ("GONE CATEGORY: " ++)) gone_cats
  mapM_ (putStrLn . ("NEW  CATEGORY: " ++)) new_cats

  putStrLn "lambdaman goes back to sleep...\n"
