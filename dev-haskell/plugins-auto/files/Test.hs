
import System.Exit (exitFailure,exitWith,ExitCode(..))
import System.Directory
import System.IO
import Control.Monad(when)
import System.Process(rawSystem,runInteractiveCommand,terminateProcess)
import Control.Exception
import Control.Concurrent


tempFolder = "Test/tmp"

main = do
  putStrLn "Testing!"
  e <- doesDirectoryExist tempFolder
  when e$ removeDirectoryRecursive tempFolder
  check$ rawSystem "cp" ["-r","Test/Interactive",tempFolder]
  putStrLn "compiling test program ..."
  check$ rawSystem "ghc" ["--make","-i"++tempFolder,"-odir",tempFolder,"-hidir",tempFolder,"Main"]
  putStrLn "running test program ..."
  setCurrentDirectory tempFolder
  bracket
    (runInteractiveCommand "./Main")
    (\(ih,oh,eh,ph) -> terminateProcess ph)
    $ \(ih,oh,eh,ph) -> do
        hSetBinaryMode ih False
        hSetBinaryMode oh False
        hSetBuffering ih NoBuffering
        hSetBuffering oh NoBuffering
        hPutStrLn ih "a"
        "a" <- hGetLine oh
        putStrLn "modifying original program ..."
        writeFile "Answer.hs"$
             "module Answer where"
           ++"\nimport System.IO(hFlush,stdout)"
           ++"\ngetAnswer :: String -> IO ()"
           ++"\ngetAnswer input = do"
           ++"\nputStrLn$ input++input"
           ++"\nhFlush stdout"
        threadDelay$ 900*1000 -- wait for the changes to be applied
        putStrLn "testing modified program ..."
        hPutStrLn ih "b"
        "bb" <- hGetLine oh
        return ()
 where
  check io = io >>= \c -> case c of { ExitSuccess -> return (); _ -> exitWith c }


