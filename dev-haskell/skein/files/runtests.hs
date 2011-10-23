-- from base
import Control.Applicative ((<$>))
import Control.Monad (forM_, unless)
import Data.Char (isNumber)
import Data.Maybe (catMaybes)
import Text.Printf

-- from bytestring
import qualified Data.ByteString as B
--import qualified Data.ByteString.Lazy as L

-- from cereal
import Data.Serialize (encode)

-- from tagged
import Data.Tagged (Tagged(..))

-- from crypto-api
import Crypto.Classes


-- from filepath
import System.FilePath ((</>))

-- from transformers
import Control.Monad.Trans.Writer.Lazy (Writer)

-- from hspec
import Test.Hspec.Monadic
--import Test.Hspec.QuickCheck
import Test.Hspec.HUnit ()


-- from this package
import Paths_skein (getDataFileName)
import Crypto.Skein




main :: IO ()
main = do
  skein_golden_kat_txt <- getDataFileName ("tests" </> "skein_golden_kat.txt")
  kats <- parseKats <$> readFile skein_golden_kat_txt
  putStrLn $ "Parsed " ++ show (length kats) ++ " known answer tests"
  hspecX $ do
         describe "Skein golden known answer tests" $ do
           skeinKats kats (undefined :: Skein_512_512)
           skeinKats kats (undefined :: Skein_1024_1024)
           skeinKats kats (undefined :: Skein_256_256)
           skeinKats kats (undefined :: Skein_256_128)
           skeinKats kats (undefined :: Skein_256_160)
           skeinKats kats (undefined :: Skein_256_224)
           skeinKats kats (undefined :: Skein_512_128)
           skeinKats kats (undefined :: Skein_512_160)
           skeinKats kats (undefined :: Skein_512_224)
           skeinKats kats (undefined :: Skein_512_256)
           skeinKats kats (undefined :: Skein_512_384)
           skeinKats kats (undefined :: Skein_1024_384)
           skeinKats kats (undefined :: Skein_1024_512)

readMsg :: Read a => String -> String -> a
readMsg msg str = case readsPrec 0 str of
                    [(r, "")] -> r
                    _ -> error msg

----------------------------------------------------------------------

data Kat = Kat { skeinType :: SkeinType
               , message   :: B.ByteString
               , macKey    :: Maybe B.ByteString
               , result    :: B.ByteString
               }

data SkeinType = Skein !Int !Int deriving (Eq)

instance Show SkeinType where
    show (Skein s o) = printf "Skein-%d-%d" s o

parseKats :: String -> [Kat]
parseKats = catMaybes . map parseKat . groupKats . lines . filter (/= '\r')

groupKats :: [String] -> [[String]]
groupKats = go []
    where
      sep = "--------------------------------"
      go acc (x:xs) | x == sep  = reverse acc : go [] xs
                    | otherwise = go (x:acc) xs
      go []    []               = []
      go (_:_) []               = error "groupKats: didn't find last separator"

parseKat :: [String] -> Maybe Kat
parseKat ("":xs) = parseKat xs
parseKat (header:"":rest) =
    case (isTree header, parseMsgLen header, parseBlocks rest) of
      (_, msgLen, _) | msgLen `mod` 8 /= 0 -> Nothing
      (False, _, [Message msg,             Result ret]) -> kat msg Nothing    ret
      (False, _, [Message msg, MACKey mac, Result ret]) -> kat msg (Just mac) ret
      _ -> Nothing
    where kat msg mac ret = Just $ Kat (parseSkeinType header) msg mac ret
parseKat _ = Nothing

isTree :: String -> Bool
isTree ('T':'r':'e':'e':':':_) = True
isTree (_:xs) = isTree xs
isTree []     = False

parseMsgLen :: String -> Int
parseMsgLen ('m':'s':'g':'L':'e':'n':' ':'=':xs) = readMsg "parseMsgLen" $ take 6 xs
parseMsgLen (_:xs) = parseMsgLen xs
parseMsgLen []     = error "parseMsgLen: didn't find msgLen"

parseSkeinType :: String -> SkeinType
parseSkeinType xs0 =
    let (":Skein", '-':xs1) = break (== '-') xs0
        (stateS,   xs2)     = span isNumber xs1
        (':':_,    xs3)     = break isNumber xs2
        (outputS,  _)       = span isNumber xs3
    in Skein (readMsg "stateS" stateS) (readMsg "outputS" outputS)

data Block = Message B.ByteString | MACKey B.ByteString | Result B.ByteString

block :: String -> B.ByteString -> Block
block "Message data:" = Message
block "Result:"       = Result
block ('M':'A':'C':_) = MACKey
block x               = error $ "block: unknown block type " ++ x

parseBlocks :: [String] -> [Block]
parseBlocks [] = []
parseBlocks (header:rest)
    | last header /= ':' = error "parseBlocks: something went wrong"
    | otherwise          = let (data_, rest') = span ((== ' ') . head) rest
                           in block header (parseData data_) : parseBlocks rest'

parseData :: [String] -> B.ByteString
parseData [' ':' ':' ':' ':'(':'n':'o':'n':'e':')':_] = B.empty
parseData xs = B.pack $ map (readMsg "parseData" . ("0x"++)) $ concatMap words xs

----------------------------------------------------------------------

skeinKats :: (SkeinMAC skeinCtx, Hash skeinCtx digest) =>
             [Kat] -> digest -> Writer [ItSpec] ()
skeinKats kats digest =
  let get t@(Tagged x) = x
          where
            f :: Tagged d a -> d
            f = undefined

            p = f t `asTypeOf` digest
      skeinType = Skein (get blockLength) (get outputLength)
      myHashKats  = [(msg,         ret) | Kat t msg Nothing       ret <- kats, t == skeinType]
      myMacKats   = [(msg, macKey, ret) | Kat t msg (Just macKey) ret <- kats, t == skeinType]
      lenHashKats = length myHashKats
      lenMacKats  = length myMacKats
      testName =
          if lenHashKats + lenMacKats == 0
          then printf "has no tests for %s =(" (show skeinType)
          else printf "works for %s (%d hash tests, %d MAC tests)"
                      (show skeinType) lenHashKats lenMacKats
  in it testName $ do
       putStrLn "Testing hashes..."
       forM_ myHashKats $ \(msg, ret) -> do
         let myHash = hash' msg `asTypeOf` digest
         unless (encode myHash == ret) $ fail $ concat ["Message: ", show msg,
                                                        "\nExpected: ", show ret,
                                                        "\nCalculated: ", show (encode myHash)]
       putStrLn "Testing MACs..."
       forM_ myMacKats $ \(msg, macKey, ret) -> do
         let myMAC = skeinMAC' macKey msg `asTypeOf` digest
         unless (encode myMAC == ret) $ fail $ concat ["Message: ", show msg,
                                                       "MAC Key: ", show macKey,
                                                       "\nExpected: ", show ret,
                                                       "\nCalculated: ", show (encode myMAC)]
