{-
{-# LANGUAGE OverloadedStrings #-}
import Filesystem.Path.CurrentOS
-}
import System.FSNotify
import Filesystem

main :: IO ()
main = do
  -- let wd = "."
  wd <- getWorkingDirectory
  print wd
  man <- startManager
  watchTree man wd (const True) print
  print "press retrun to stop"
  getLine
  print "watching stopped, press retrun to exit"
  stopManager man
  getLine
  return ()
