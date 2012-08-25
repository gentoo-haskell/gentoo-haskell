-- |HUnit tests and QuickQuick properties for Happstack.Server.*
module Happstack.Server.Tests (allTests) where

import qualified Codec.Compression.GZip as GZ
import qualified Codec.Compression.Zlib as Z
import Control.Arrow ((&&&))
import Control.Applicative ((<$>))
import Control.Concurrent.MVar
import Control.Monad
import Data.ByteString.Lazy.Char8     (pack, unpack)
import qualified Data.ByteString.Char8 as B
import qualified Data.ByteString.Lazy  as L
import qualified Data.Map              as Map
import Happstack.Server                      ( Request(..), Method(..), Response(..), ServerPart, Headers, RqBody(Body), HttpVersion(..)
                                             , ToMessage(..), HeaderPair(..), ok, dir, simpleHTTP'', composeFilter, noContentLength, matchMethod)
import Happstack.Server.FileServe.BuildingBlocks (sendFileResponse)
import Happstack.Server.Cookie
import Happstack.Server.Internal.Compression
import Happstack.Server.Internal.Cookie
import Happstack.Server.Internal.Multipart
import Happstack.Server.Internal.MessageWrap
import Happstack.Server.SURI(ToSURI(..), path, query)
import Test.HUnit as HU (Test(..), (~:), (@?=), (@=?), assertEqual)
import Text.ParserCombinators.Parsec

-- |All of the tests for happstack-util should be listed here.
allTests :: Test
allTests =
    "happstack-server tests" ~: [ cookieParserTest
                                , acceptEncodingParserTest
                                , multipart
                                , compressFilterResponseTest
                                , matchMethodTest
                                ]

cookieParserTest :: Test
cookieParserTest =
    "cookieParserTest" ~:
    [parseCookies "$Version=1;Cookie1=value1;$Path=\"/testpath\";$Domain=example.com;cookie2=value2"
        @?= (Right [
            Cookie "1" "/testpath" "example.com" "cookie1" "value1" False False
          , Cookie "1" "" "" "cookie2" "value2" False False
          ])
    ,parseCookies "  \t $Version = \"1\" ; cookie1 = \"randomcrap!@#%^&*()-_+={}[]:;'<>,.?/\\|\" , $Path=/  "
        @?= (Right [
            Cookie "1" "/" "" "cookie1" "randomcrap!@#%^&*()-_+={}[]:;'<>,.?/|" False False
          ])
    ,parseCookies " cookie1 = value1  "
        @?= (Right [
            Cookie "" "" "" "cookie1" "value1" False False
          ])
    ,parseCookies " $Version=\"1\";buggygooglecookie = valuewith=whereitshouldnotbe  "
        @?= (Right [
            Cookie "1" "" "" "buggygooglecookie" "valuewith=whereitshouldnotbe" False False
          ])
    , parseCookies "foo=\"\\\"bar\\\"\""
        @?= (Right [
              Cookie "" "" ""  "foo" "\"bar\"" False False
             ])
    ]

acceptEncodingParserTest :: Test
acceptEncodingParserTest =
    "acceptEncodingParserTest" ~:
    map (\(str, result) -> either (Left . show) Right (parse encodings "" str) @?= (Right result)) acceptEncodings
    where
      acceptEncodings =
       [ (" gzip;q=1,*, compress ; q = 0.5 ", [("gzip", Just 1),("*", Nothing),("compress", Just 0.5)])
       , (" compress , gzip", [ ("compress", Nothing), ("gzip", Nothing)])
       , (" ", [])
       , (" *", [("*", Nothing)])
       , (" compress;q=0.5, gzip;q=1.0", [("compress", Just 0.5), ("gzip", Just 1.0)])
       , (" gzip;q=1.0, identity; q=0.5, *;q=0", [("gzip", Just 1.0), ("identity",Just 0.5), ("*", Just 0)])
       , (" x-gzip",[("x-gzip", Nothing)])
       ]

multipart :: Test
multipart =
    "split multipart" ~:
    [ ([BodyPart (pack "content-type: text/plain\r\n") (pack "1")], Nothing) @=?
           parseMultipartBody (pack "boundary")
                      (pack "--boundary\r\ncontent-type: text/plain\r\n\r\n1\r\n--boundary--\r\nend")

    , ([BodyPart (pack "content-type: text/plain\r\n") (pack "1")], Nothing) @=?
           parseMultipartBody (pack "boundary.with.dot")
                      (pack "--boundary.with.dot\r\ncontent-type: text/plain\r\n\r\n1\r\n--boundary.with.dot--\r\nend")

    , ([BodyPart (pack "content-type: text/plain\r\n") (pack "1")], Nothing) @=?
           parseMultipartBody (pack "boundary")
                      (pack "beg\r\n--boundary\r\ncontent-type: text/plain\r\n\r\n1\r\n--boundary--\r\nend")

    , ([BodyPart (pack "content-type: text/plain\r\n") (pack "1\n")], Nothing) @=?
           parseMultipartBody (pack "boundary")
                      (pack "beg\r\n--boundary\r\ncontent-type: text/plain\r\n\r\n1\n\r\n--boundary--\r\nend")

    , ([BodyPart (pack "content-type: text/plain\r\n") (pack "1\r\n")], Nothing) @=?
           parseMultipartBody (pack "boundary")
                      (pack "beg\r\n--boundary\r\ncontent-type: text/plain\r\n\r\n1\r\n\r\n--boundary--\r\nend")
    , ([BodyPart (pack "content-type: text/plain\r\n") (pack "1\n\r")], Nothing) @=?
           parseMultipartBody (pack "boundary")
                      (pack "beg\r\n--boundary\r\ncontent-type: text/plain\r\n\r\n1\n\r\r\n--boundary--\r\nend")

    , ([BodyPart (pack "content-type: text/plain\r\n") (pack "\r\n1\n\r")], Nothing) @=?
           parseMultipartBody (pack "boundary")
                      (pack "beg\r\n--boundary\r\ncontent-type: text/plain\r\n\r\n\r\n1\n\r\r\n--boundary--\r\nend")
    ]

compressFilterResponseTest :: Test
compressFilterResponseTest =
    "compressFilterResponseTest" ~:
     [ uncompressedResponse
     , uncompressedSendFile
     , compressedResponseGZ
     , compressedResponseZ
     , compressedSendFile
     , compressedSendFileNoIdentity
     ]

mkRequest :: Method -> String -> [(String, Cookie)] -> Headers -> L.ByteString -> IO Request
mkRequest method uri cookies headers body =
    do let u = toSURI uri
       ib <- newEmptyMVar
       b  <- newMVar (Body body)
       return $ Request { rqMethod      = method
                        , rqPaths       = (pathEls (path u))
                        , rqUri         = (path u)
                        , rqQuery       = (query u)
                        , rqInputsQuery = (queryInput u)
                        , rqInputsBody  = ib
                        , rqCookies     = cookies
                        , rqVersion     = HttpVersion 1 1
                        , rqHeaders     = headers
                        , rqBody        = b
                        , rqPeer        = ("",0)
                        , rqSecure      = False
                        }

compressPart :: ServerPart Response
compressPart =
    do void compressedResponseFilter
       composeFilter noContentLength
       msum [ dir "response" $ ok (toResponse "compress Response")
            , dir "sendfile" $ ok (sendFileResponse "text/plain" "/dev/null" Nothing 0 100)
            ]

uncompressedResponse :: Test
uncompressedResponse =
    "uncompressedResponse" ~:
      do req <- mkRequest GET "/response" [] Map.empty L.empty
         res <- simpleHTTP'' compressPart req
         assertEqual "respone code"     (rsCode res) 200
         assertEqual "body"             (unpack (rsBody res)) "compress Response"
         assertEqual "Content-Encoding" ((hName &&& hValue) <$> Map.lookup (B.pack "content-encoding") (rsHeaders res)) Nothing

uncompressedSendFile :: Test
uncompressedSendFile =
    "uncompressedSendFile" ~:
      do req <- mkRequest GET "/sendfile" [] Map.empty L.empty
         res <- simpleHTTP'' compressPart req
         assertEqual "respone code"     (rsCode res) 200
         assertEqual "filepath"         (sfFilePath res) "/dev/null"
         assertEqual "Content-Encoding" ((hName &&& hValue) <$> Map.lookup (B.pack "content-encoding") (rsHeaders res)) Nothing

compressedResponseGZ :: Test
compressedResponseGZ =
    "compressedResponseGZ" ~:
      do req <- mkRequest GET "/response" [] (Map.singleton (B.pack "accept-encoding") (HeaderPair (B.pack "Accept-Encoding") [B.pack " gzip;q=1"])) L.empty
         res <- simpleHTTP'' compressPart req
         assertEqual "respone code"     (rsCode res) 200
         assertEqual "body"             (unpack (GZ.decompress (rsBody res))) ("compress Response")
         assertEqual "Content-Encoding" ((hName &&& hValue) <$> Map.lookup (B.pack "content-encoding") (rsHeaders res)) (Just (B.pack "Content-Encoding", [B.pack "gzip"]))

compressedResponseZ :: Test
compressedResponseZ =
    "compressedResponseZ" ~:
      do req <- mkRequest GET "/response" [] (Map.singleton (B.pack "accept-encoding") (HeaderPair (B.pack "Accept-Encoding") [B.pack " deflate;q=1"])) L.empty
         res <- simpleHTTP'' compressPart req
         assertEqual "respone code"     (rsCode res) 200
         assertEqual "body"             (unpack (Z.decompress (rsBody res))) ("compress Response")
         assertEqual "Content-Encoding" ((hName &&& hValue) <$> Map.lookup (B.pack "content-encoding") (rsHeaders res)) (Just (B.pack "Content-Encoding", [B.pack "deflate"]))

compressedSendFile :: Test
compressedSendFile =
    "compressedSendfile" ~:
      do req <- mkRequest GET "/sendfile" [] (Map.singleton (B.pack "accept-encoding") (HeaderPair (B.pack "Accept-Encoding") [B.pack " gzip;q=1"])) L.empty
         res <- simpleHTTP'' compressPart req
         assertEqual "respone code"     (rsCode res) 200
         assertEqual "filepath"         (sfFilePath res) "/dev/null"
         assertEqual "Content-Encoding" ((hName &&& hValue) <$> Map.lookup (B.pack "content-encoding") (rsHeaders res)) Nothing

compressedSendFileNoIdentity :: Test
compressedSendFileNoIdentity =
    "compressedSendFileNoIdentity" ~:
      do req <- mkRequest GET "/sendfile" [] (Map.singleton (B.pack "accept-encoding") (HeaderPair (B.pack "Accept-Encoding") [B.pack " gzip;q=1, identity: q=0.0"])) L.empty
         res <- simpleHTTP'' compressPart req
         assertEqual "respone code"     (rsCode res) 406
         assertEqual "body"             (unpack (rsBody res)) ""
         assertEqual "Content-Encoding" ((hName &&& hValue) <$> Map.lookup (B.pack "content-encoding") (rsHeaders res)) Nothing

matchMethodTest :: Test
matchMethodTest =
    "matchMethodTest" ~:
      do forM_ gethead $ \m -> matchMethod GET m @?= True
         forM_ others  $ \m -> matchMethod GET m @?= False
         forM_ gethead $ \m -> matchMethod [GET] m @?= True
         forM_ others  $ \m -> matchMethod [GET] m @?= False
         forM_ gethead $ \m -> matchMethod [GET, HEAD] m @?= True
         forM_ others  $ \m -> matchMethod [GET, HEAD] m @?= False
         matchMethod POST GET   @?= False
         matchMethod POST HEAD  @?= False
         matchMethod POST TRACE @?= False
         matchMethod POST POST  @?= True
         matchMethod [POST, PUT] GET   @?= False
         matchMethod [POST, PUT] HEAD  @?= False
         matchMethod [POST, PUT] TRACE @?= False
         matchMethod [POST, PUT] POST  @?= True
         matchMethod [POST, PUT] PUT   @?= True
         forM_ (others) $ \m -> matchMethod (`notElem` gethead) m @?= True
         forM_ (gethead ++ others) $ \m -> matchMethod () m @?= True
  where
    gethead = [GET, HEAD]
    others  = [POST, PUT, DELETE, TRACE, OPTIONS, CONNECT]
