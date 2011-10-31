{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
import Test.HUnit
import Test.Hspec.Monadic
import Test.QuickCheck hiding (property)
import Test.Hspec.QuickCheck
import Test.Hspec.HUnit ()
import Control.Monad (replicateM)

import qualified Data.ByteString as S
import qualified Data.ByteString.Char8 as S8

import Web.ClientSession
import System.IO.Unsafe

main :: IO ()
main = hspecX $ describe "client session" $ do
    it "encrypt/decrypt success" $ property propEncDec
    it "encrypt/decrypt failure" $ property propEncDecFailure
    it "AES encrypt/decrypt success" $ property propAES
    it "AES encryption changes bs" $ property propAESChanges
    it "specific values" caseSpecific

propEncDec :: S.ByteString -> Bool
propEncDec bs = unsafePerformIO $ do
    key <- getDefaultKey
    s <- encryptIO key bs
    let bs' = decrypt key s
    return $ Just bs == bs'

propEncDecFailure :: S.ByteString -> Bool
propEncDecFailure bs = unsafePerformIO $ do
    key <- getDefaultKey
    s <- encryptIO key bs
    let bs' = decrypt key $ (S.head s + 1) `S.cons` S.drop 1 s
    return $ Just bs /= bs'

propAES :: Key -> IV -> S.ByteString -> Bool
propAES key iv bs = decrypt key (encrypt key iv bs) == Just bs

propAESChanges :: Key -> IV -> S.ByteString -> Bool
propAESChanges key iv bs = encrypt key iv bs /= bs

caseSpecific :: Assertion
caseSpecific = do
    let s = S8.pack $ show [("lo\ENQ\143XAq","\DC2\207\226\DC1;.z56|\203\222"),("\USnu#\139\ETXB\201 ","l"),("\RS\b,zM2U\184\191F)\EOT\220S\NUL","O\\\GSd\247\246\n\EOT\SYN\182U2G"),("\219\NAK\217\CAN\252","ym\STX\188\232?\\\145"),("\239k","\vRZP\a\DC2F>"),("\FS\180P &\RS\174zSL\\?@","p\170\237vZ|\GS>\SYNk\176n\r"),("","\199D\DC3\200m)"),("6\152tVhB\246)9","\ENQdfU\SUB"),("I\ACK\181\NUL","\129\&6s\130q\US)oR1\197\FSp\US\SYN0"),("\183\200<\250","\211  \131g4\207N\155"),("\248O6k\CANK\135\234.","`\205!+&Z&9\DLE\244\214HP\SI\161"),("\"I'\ACK\149 \CAN\197","\141N\201\SO\204\\o.\128\148")]
    key <- getDefaultKey
    iv <- randomIV
    Just s @=? decrypt key (encrypt key iv s)
    let s' = S.concat $ replicate 500 s
    Just s' @=? decrypt key (encrypt key iv s')

instance Arbitrary S.ByteString where
    arbitrary = S.pack `fmap` arbitrary

instance Arbitrary Key where
    arbitrary = do
        keySize <- ((+32) . (`mod` 64)) `fmap` arbitrary
        ws <- replicateM keySize arbitrary
        either error return $ initKey $ S.pack ws

instance Arbitrary IV where
    arbitrary = do
        ws <- replicateM 16 arbitrary
        maybe (error "Invalid IV") return $ mkIV $ S.pack ws
