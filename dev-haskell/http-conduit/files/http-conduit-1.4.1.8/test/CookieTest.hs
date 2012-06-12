module CookieTest (cookieTest) where

import Prelude hiding (exp)
import Test.Hspec.Monadic
import Test.Hspec.HUnit ()
import qualified Data.ByteString as BS
import Test.HUnit hiding (path)
import Network.HTTP.Conduit.Cookies
import qualified Network.HTTP.Conduit as HC
import Data.ByteString.UTF8
import Data.Maybe
import Data.Time.Clock
import Data.Time.Calendar
import qualified Data.CaseInsensitive as CI
import Web.Cookie

default_request :: HC.Request m
default_request = fromJust $ HC.parseUrl "http://www.google.com/"

default_cookie :: Cookie
default_cookie = Cookie { cookie_name = fromString "name"
                        , cookie_value = fromString "value"
                        , cookie_expiry_time = default_time
                        , cookie_domain = fromString "www.google.com"
                        , cookie_path = fromString "/"
                        , cookie_creation_time = default_time
                        , cookie_last_access_time = default_time
                        , cookie_persistent = False
                        , cookie_host_only = False
                        , cookie_secure_only = False
                        , cookie_http_only = False
                        }

default_time :: UTCTime
default_time = UTCTime (ModifiedJulianDay 56200) (secondsToDiffTime 0)

default_diff_time :: DiffTime
default_diff_time = secondsToDiffTime 1209600

default_set_cookie :: SetCookie
default_set_cookie = def       { setCookieName = fromString "name"
                               , setCookieValue = fromString "value"
                               , setCookiePath = Just $ fromString "/"
                               , setCookieExpires = Just default_time
                               , setCookieMaxAge = Just default_diff_time
                               , setCookieDomain = Just $ fromString "www.google.com"
                               , setCookieHttpOnly = False
                               , setCookieSecure = False
                               }

testValidIp :: Test
testValidIp = TestCase $ assertBool "Couldn't parse valid IP address" $
  isIpAddress $ fromString "1.2.3.4"

testIpNumTooHigh :: Test
testIpNumTooHigh = TestCase $ assertBool "One of the digits in the IP address is too large" $
  not $ isIpAddress $ fromString "501.2.3.4"

testTooManySegmentsInIp :: Test
testTooManySegmentsInIp = TestCase $ assertBool "Too many segments in the ip address" $
  not $ isIpAddress $ fromString "1.2.3.4.5"

testCharsInIp :: Test
testCharsInIp = TestCase $ assertBool "Chars are not allowed in IP addresses" $
  not $ isIpAddress $ fromString "1.2a3.4.5"

testDomainMatchesSuccess :: Test
testDomainMatchesSuccess = TestCase $ assertBool "Domains should match" $
  domainMatches (fromString "www.google.com") (fromString "google.com")

testSameDomain :: Test
testSameDomain = TestCase $ assertBool "Same domain should match" $
  domainMatches domain domain
  where domain = fromString "www.google.com"

testSiblingDomain :: Test
testSiblingDomain = TestCase $ assertBool "Sibling domain should not match" $
  not $ domainMatches (fromString "www.google.com") (fromString "secure.google.com")

testParentDomain :: Test
testParentDomain = TestCase $ assertBool "Parent domain should fail" $
  not $ domainMatches (fromString "google.com") (fromString "www.google.com")

testNaiveSuffixDomain :: Test
testNaiveSuffixDomain = TestCase $ assertBool "Naively checking for suffix for domain matching should fail" $
  not $ domainMatches (fromString "agoogle.com") (fromString "google.com")

testDefaultPath :: Test
testDefaultPath = TestCase $ assertEqual "Getting default path from a request"
  (fromString "/") (defaultPath default_request)

testShortDefaultPath :: Test
testShortDefaultPath = TestCase $ assertEqual "Getting default path from a short path"
  (fromString "/") (defaultPath $ default_request {HC.path = fromString "/search"})

testPopulatedDefaultPath :: Test
testPopulatedDefaultPath = TestCase $ assertEqual "Getting default path from a request with a path"
  (fromString "/search") (defaultPath $ default_request {HC.path = fromString "/search/term"})

testParamsDefaultPath :: Test
testParamsDefaultPath = TestCase $ assertEqual "Getting default path from a request with a path and GET params"
  (fromString "/search") (defaultPath $ default_request {HC.path = fromString "/search/term?var=val"})

testDefaultPathEndingInSlash :: Test
testDefaultPathEndingInSlash = TestCase $ assertEqual "Getting default path that ends in a slash"
  (fromString "/search/term") (defaultPath $ default_request {HC.path = fromString "/search/term/"})

testSamePathsMatch :: Test
testSamePathsMatch = TestCase $ assertBool "The same path should match" $
  pathMatches path path
  where path = fromString "/a/path"

testPathSlashAtEnd :: Test
testPathSlashAtEnd = TestCase $ assertBool "Putting the slash at the end should still match paths" $
  pathMatches (fromString "/a/path/to/here") (fromString "/a/path/")

testPathNoSlashAtEnd :: Test
testPathNoSlashAtEnd = TestCase $ assertBool "Not putting the slash at the end should still match paths" $
  pathMatches (fromString "/a/path/to/here") (fromString "/a/path")

testDivergingPaths :: Test
testDivergingPaths = TestCase $ assertBool "Diverging paths don't match" $
  not $ pathMatches (fromString "/a/path/to/here") (fromString "/a/different/path")

testCookieEqualitySuccess :: Test
testCookieEqualitySuccess = TestCase $ assertEqual "The same cookies should be equal"
  cookie cookie
  where cookie = default_cookie

testCookieEqualityResiliance :: Test
testCookieEqualityResiliance = TestCase $ assertEqual "Cookies should still be equal if extra options are changed"
  (default_cookie {cookie_persistent = True}) (default_cookie {cookie_host_only = True})

testDomainChangesEquality :: Test
testDomainChangesEquality = TestCase $ assertBool "Changing the domain should make cookies not equal" $
  default_cookie /= (default_cookie {cookie_domain = fromString "/search"})

testRemoveCookie :: Test
testRemoveCookie = TestCase $ assertEqual "Removing a cookie works"
  (Just default_cookie, createCookieJar []) (removeExistingCookieFromCookieJar default_cookie $ createCookieJar [default_cookie])

testRemoveNonexistantCookie :: Test
testRemoveNonexistantCookie = TestCase $ assertEqual "Removing a nonexistant cookie doesn't work"
  (Nothing, createCookieJar [default_cookie]) (removeExistingCookieFromCookieJar (default_cookie {cookie_name = fromString "key2"}) $ createCookieJar [default_cookie])

testRemoveCorrectCookie :: Test
testRemoveCorrectCookie = TestCase $ assertEqual "Removing only the correct cookie"
  (Just search_for, createCookieJar [red_herring]) (removeExistingCookieFromCookieJar search_for $ createCookieJar [red_herring, search_for])
  where search_for = default_cookie {cookie_name = fromString "name1"}
        red_herring = default_cookie {cookie_name = fromString "name2"}

testEvictExpiredCookies :: Test
testEvictExpiredCookies = TestCase $ assertEqual "Evicting expired cookies works"
  (createCookieJar [a, c]) (evictExpiredCookies (createCookieJar [a, b, c, d]) middle)
  where a = default_cookie { cookie_name = fromString "a"
                           , cookie_expiry_time = UTCTime (ModifiedJulianDay 3) (secondsToDiffTime 0)
                           }
        b = default_cookie { cookie_name = fromString "b"
                           , cookie_expiry_time = UTCTime (ModifiedJulianDay 1) (secondsToDiffTime 0)
                           }
        c = default_cookie { cookie_name = fromString "c"
                           , cookie_expiry_time = UTCTime (ModifiedJulianDay 3) (secondsToDiffTime 0)
                           }
        d = default_cookie { cookie_name = fromString "d"
                           , cookie_expiry_time = UTCTime (ModifiedJulianDay 1) (secondsToDiffTime 0)
                           }
        middle = UTCTime (ModifiedJulianDay 2) (secondsToDiffTime 0)

testEvictNoCookies :: Test
testEvictNoCookies = TestCase $ assertEqual "Evicting empty cookie jar"
  (createCookieJar []) (evictExpiredCookies (createCookieJar []) middle)
  where middle = UTCTime (ModifiedJulianDay 2) (secondsToDiffTime 0)

testComputeCookieStringUpdateLastAccessTime :: Test
testComputeCookieStringUpdateLastAccessTime = TestCase $ assertEqual "Updates last access time upon using cookies"
  (fromString "name=value", out_cookie_jar) (computeCookieString request cookie_jar now True)
  where request = default_request
        cookie_jar = createCookieJar [default_cookie]
        now = UTCTime (ModifiedJulianDay 0) (secondsToDiffTime 1)
        out_cookie_jar = createCookieJar [default_cookie {cookie_last_access_time = now}]

testComputeCookieStringHostOnly :: Test
testComputeCookieStringHostOnly = TestCase $ assertEqual "Host only cookies should match host exactly"
  (fromString "name=value", cookie_jar) (computeCookieString request cookie_jar default_time True)
  where request = default_request
        cookie_jar = createCookieJar [default_cookie {cookie_host_only = True}]

testComputeCookieStringHostOnlyFilter :: Test
testComputeCookieStringHostOnlyFilter = TestCase $ assertEqual "Host only cookies shouldn't match subdomain"
  (fromString "", cookie_jar) (computeCookieString request cookie_jar default_time True)
  where request = default_request {HC.host = fromString "sub1.sub2.google.com"}
        cookie_jar = createCookieJar [default_cookie { cookie_host_only = True
                                                     , cookie_domain = fromString "sub2.google.com"
                                                     }
                                     ]

testComputeCookieStringDomainMatching :: Test
testComputeCookieStringDomainMatching = TestCase $ assertEqual "Domain matching works for new requests"
  (fromString "name=value", cookie_jar) (computeCookieString request cookie_jar default_time True)
  where request = default_request {HC.host = fromString "sub1.sub2.google.com"}
        cookie_jar = createCookieJar [default_cookie {cookie_domain = fromString "sub2.google.com"}]

testComputeCookieStringPathMatching :: Test
testComputeCookieStringPathMatching = TestCase $ assertEqual "Path matching works for new requests"
  (fromString "name=value", cookie_jar) (computeCookieString request cookie_jar default_time True)
  where request = default_request {HC.path = fromString "/a/path/to/nowhere"}
        cookie_jar = createCookieJar [default_cookie {cookie_path = fromString "/a/path"}]

testComputeCookieStringPathMatchingFails :: Test
testComputeCookieStringPathMatchingFails = TestCase $ assertEqual "Path matching fails when it should"
  (fromString "", cookie_jar) (computeCookieString request cookie_jar default_time True)
  where request = default_request {HC.path = fromString "/a/different/path/to/nowhere"}
        cookie_jar = createCookieJar [default_cookie {cookie_path = fromString "/a/path"}]

testComputeCookieStringPathMatchingWithParms :: Test
testComputeCookieStringPathMatchingWithParms = TestCase $ assertEqual "Path matching succeeds when request has GET params"
  (fromString "name=value", cookie_jar) (computeCookieString request cookie_jar default_time True)
  where request = default_request {HC.path = fromString "/a/path/to/nowhere?var=val"}
        cookie_jar = createCookieJar [default_cookie {cookie_path = fromString "/a/path"}]

testComputeCookieStringSecure :: Test
testComputeCookieStringSecure = TestCase $ assertEqual "Secure flag filters properly"
  (fromString "", cookie_jar) (computeCookieString default_request cookie_jar default_time True)
  where cookie_jar = createCookieJar [default_cookie {cookie_secure_only = True}]

testComputeCookieStringHttpOnly :: Test
testComputeCookieStringHttpOnly = TestCase $ assertEqual "http-only flag filters properly"
  (fromString "", cookie_jar) (computeCookieString default_request cookie_jar default_time False)
  where cookie_jar = createCookieJar [default_cookie {cookie_http_only = True}]

testComputeCookieStringSort :: Test
testComputeCookieStringSort = TestCase $ assertEqual "Sorting works correctly"
  (fromString "c1=v1;c3=v3;c4=v4;c2=v2", cookie_jar_out) format_output
  where now = UTCTime (ModifiedJulianDay 10) (secondsToDiffTime 11)
        cookie_jar = createCookieJar [ default_cookie { cookie_name = fromString "c1"
                                                      , cookie_value = fromString "v1"
                                                      , cookie_path = fromString "/all/encompassing/request"
                                                      }
                                     , default_cookie { cookie_name = fromString "c2"
                                                      , cookie_value = fromString "v2"
                                                      , cookie_path = fromString "/all"
                                                      }
                                     , default_cookie { cookie_name = fromString "c3"
                                                      , cookie_value = fromString "v3"
                                                      , cookie_path = fromString "/all/encompassing"
                                                      , cookie_creation_time = UTCTime (ModifiedJulianDay 0) (secondsToDiffTime 1)
                                                      }
                                     , default_cookie { cookie_name = fromString "c4"
                                                      , cookie_value = fromString "v4"
                                                      , cookie_path = fromString "/all/encompassing"
                                                      , cookie_creation_time = UTCTime (ModifiedJulianDay 0) (secondsToDiffTime 2)
                                                      }
                                     ]
        cookie_jar_out = createCookieJar [ default_cookie { cookie_name = fromString "c1"
                                                          , cookie_value = fromString "v1"
                                                          , cookie_path = fromString "/all/encompassing/request"
                                                          , cookie_last_access_time = now
                                                          }
                                         , default_cookie { cookie_name = fromString "c2"
                                                          , cookie_value = fromString "v2"
                                                          , cookie_path = fromString "/all"
                                                          , cookie_last_access_time = now
                                                          }
                                         , default_cookie { cookie_name = fromString "c3"
                                                          , cookie_value = fromString "v3"
                                                          , cookie_path = fromString "/all/encompassing"
                                                          , cookie_creation_time = UTCTime (ModifiedJulianDay 0) (secondsToDiffTime 1)
                                                          , cookie_last_access_time = now
                                                          }
                                         , default_cookie { cookie_name = fromString "c4"
                                                          , cookie_value = fromString "v4"
                                                          , cookie_path = fromString "/all/encompassing"
                                                          , cookie_creation_time = UTCTime (ModifiedJulianDay 0) (secondsToDiffTime 2)
                                                          , cookie_last_access_time = now
                                                          }
                                         ]
        request = default_request {HC.path = fromString "/all/encompassing/request/path"}
        format_output = computeCookieString request cookie_jar default_time False

testInsertCookiesIntoRequestWorks :: Test
testInsertCookiesIntoRequestWorks = TestCase $ assertEqual "Inserting cookies works"
  [(CI.mk $ fromString "Cookie", fromString "key=val")] out_headers
  where out_headers = HC.requestHeaders req
        (req, _) = insertCookiesIntoRequest req' cookie_jar default_time
        cookie_jar = createCookieJar [ default_cookie { cookie_name = fromString "key"
                                                      , cookie_value = fromString "val"
                                                      }
                                     ]
        req' = default_request {HC.requestHeaders = [(CI.mk $ fromString "Cookie",
                                                      fromString "otherkey=otherval")]}

testReceiveSetCookie :: Test
testReceiveSetCookie = TestCase $ assertEqual "Receiving a Set-Cookie"
  (createCookieJar [default_cookie]) (receiveSetCookie default_set_cookie default_request default_time True $ createCookieJar [])

testReceiveSetCookieTrailingDot :: Test
testReceiveSetCookieTrailingDot = TestCase $ assertEqual "Receiving a Set-Cookie with a trailing domain dot"
  (createCookieJar []) (receiveSetCookie set_cookie default_request default_time True $ createCookieJar [])
  where set_cookie = default_set_cookie {setCookieDomain = Just $ fromString "www.google.com."}

testReceiveSetCookieLeadingDot :: Test
testReceiveSetCookieLeadingDot = TestCase $ assertEqual "Receiving a Set-Cookie with a leading domain dot"
  (createCookieJar [default_cookie]) (receiveSetCookie set_cookie default_request default_time True $ createCookieJar [])
  where set_cookie = default_set_cookie {setCookieDomain = Just $ fromString ".www.google.com"}

testReceiveSetCookieNoDomain :: Test
testReceiveSetCookieNoDomain = TestCase $ assertEqual "Receiving cookie without domain"
  (createCookieJar [default_cookie]) (receiveSetCookie set_cookie default_request default_time True $ createCookieJar [])
  where set_cookie = default_set_cookie {setCookieDomain = Nothing}

testReceiveSetCookieEmptyDomain :: Test
testReceiveSetCookieEmptyDomain = TestCase $ assertEqual "Receiving cookie with empty domain"
  (createCookieJar [default_cookie]) (receiveSetCookie set_cookie default_request default_time True $ createCookieJar [])
  where set_cookie = default_set_cookie {setCookieDomain = Just BS.empty}

-- Can't test public suffixes until that module is written

testReceiveSetCookieNonMatchingDomain :: Test
testReceiveSetCookieNonMatchingDomain = TestCase $ assertEqual "Receiving cookie with non-matching domain"
  (createCookieJar []) (receiveSetCookie set_cookie default_request default_time True $ createCookieJar [])
  where set_cookie = default_set_cookie {setCookieDomain = Just $ fromString "www.wikipedia.org"}

testReceiveSetCookieHostOnly :: Test
testReceiveSetCookieHostOnly = TestCase $ assertBool "Checking host-only flag gets set" $
  cookie_host_only $ head $ destroyCookieJar $ receiveSetCookie set_cookie default_request default_time True $ createCookieJar []
  where set_cookie = default_set_cookie {setCookieDomain = Nothing}

testReceiveSetCookieHostOnlyNotSet :: Test
testReceiveSetCookieHostOnlyNotSet = TestCase $ assertBool "Checking host-only flag doesn't get set" $
  not $ cookie_host_only $ head $ destroyCookieJar $ receiveSetCookie set_cookie default_request default_time True $ createCookieJar []
  where set_cookie = default_set_cookie {setCookieDomain = Just $ fromString "google.com"}

testReceiveSetCookieHttpOnly :: Test
testReceiveSetCookieHttpOnly = TestCase $ assertBool "Checking http-only flag gets set" $
  cookie_http_only $ head $ destroyCookieJar $ receiveSetCookie set_cookie default_request default_time True $ createCookieJar []
  where set_cookie = default_set_cookie {setCookieHttpOnly = True}

testReceiveSetCookieHttpOnlyNotSet :: Test
testReceiveSetCookieHttpOnlyNotSet = TestCase $ assertBool "Checking http-only flag doesn't get set" $
  not $ cookie_http_only $ head $ destroyCookieJar $ receiveSetCookie set_cookie default_request default_time True $ createCookieJar []
  where set_cookie = default_set_cookie {setCookieHttpOnly = False}

testReceiveSetCookieHttpOnlyDrop :: Test
testReceiveSetCookieHttpOnlyDrop = TestCase $ assertEqual "Checking non http request gets dropped"
  (createCookieJar []) (receiveSetCookie set_cookie default_request default_time False $ createCookieJar [])
  where set_cookie = default_set_cookie {setCookieHttpOnly = True}

testReceiveSetCookieName :: Test
testReceiveSetCookieName = TestCase $ assertEqual "Name gets set correctly"
  (fromString "name") (cookie_name $ head $ destroyCookieJar $ receiveSetCookie default_set_cookie default_request default_time True $ createCookieJar [])

testReceiveSetCookieValue :: Test
testReceiveSetCookieValue = TestCase $ assertEqual "Value gets set correctly"
  (fromString "value") (cookie_value $ head $ destroyCookieJar $ receiveSetCookie default_set_cookie default_request default_time True $ createCookieJar [])

testReceiveSetCookieExpiry :: Test
testReceiveSetCookieExpiry = TestCase $ assertEqual "Expiry gets set correctly"
  now_plus_diff_time (cookie_expiry_time $ head $ destroyCookieJar $ receiveSetCookie default_set_cookie default_request default_time True $ createCookieJar [])
  where now_plus_diff_time = ((fromRational $ toRational default_diff_time) `addUTCTime` default_time)

testReceiveSetCookieNoMaxAge :: Test
testReceiveSetCookieNoMaxAge = TestCase $ assertEqual "Expiry is based on the given value"
  default_time (cookie_expiry_time $ head $ destroyCookieJar $ receiveSetCookie cookie_without_max_age default_request default_time True $ createCookieJar [])
  where cookie_without_max_age = default_set_cookie {setCookieMaxAge = Nothing}

testReceiveSetCookieNoExpiry :: Test
testReceiveSetCookieNoExpiry = TestCase $ assertEqual "Expiry is based on max age"
  now_plus_diff_time (cookie_expiry_time $ head $ destroyCookieJar $ receiveSetCookie cookie_without_expiry default_request default_time True $ createCookieJar [])
  where now_plus_diff_time = ((fromRational $ toRational default_diff_time) `addUTCTime` default_time)
        cookie_without_expiry = default_set_cookie {setCookieExpires = Nothing}

testReceiveSetCookieNoExpiryNoMaxAge :: Test
testReceiveSetCookieNoExpiryNoMaxAge = TestCase $ assertBool "Expiry is set to a future date" $
  default_time < (cookie_expiry_time $ head $ destroyCookieJar $ receiveSetCookie basic_cookie default_request default_time True $ createCookieJar [])
  where basic_cookie = default_set_cookie { setCookieExpires = Nothing, setCookieMaxAge = Nothing }

testReceiveSetCookiePath :: Test
testReceiveSetCookiePath = TestCase $ assertEqual "Path gets set correctly"
  (fromString "/a/path") (cookie_path $ head $ destroyCookieJar $ receiveSetCookie set_cookie default_request default_time True $ createCookieJar [])
  where set_cookie = default_set_cookie {setCookiePath = Just $ fromString "/a/path"}

testReceiveSetCookieNoPath :: Test
testReceiveSetCookieNoPath = TestCase $ assertEqual "Path gets set correctly when nonexistant"
  (fromString "/a/path/to") (cookie_path $ head $ destroyCookieJar $ receiveSetCookie set_cookie request default_time True $ createCookieJar [])
  where set_cookie = default_set_cookie {setCookiePath = Nothing}
        request = default_request {HC.path = fromString "/a/path/to/nowhere"}

testReceiveSetCookieCreationTime :: Test
testReceiveSetCookieCreationTime = TestCase $ assertEqual "Creation time gets set correctly"
  now (cookie_creation_time $ head $ destroyCookieJar $ receiveSetCookie default_set_cookie default_request now True $ createCookieJar [])
  where now = UTCTime (ModifiedJulianDay 0) (secondsToDiffTime 1)

testReceiveSetCookieAccessTime :: Test
testReceiveSetCookieAccessTime = TestCase $ assertEqual "Last access time gets set correctly"
  now (cookie_last_access_time $ head $ destroyCookieJar $ receiveSetCookie default_set_cookie default_request now True $ createCookieJar [])
  where now = UTCTime (ModifiedJulianDay 0) (secondsToDiffTime 1)

testReceiveSetCookiePersistent :: Test
testReceiveSetCookiePersistent = TestCase $ assertBool "Persistent flag gets set correctly" $
  cookie_persistent $ head $ destroyCookieJar $ receiveSetCookie set_cookie default_request default_time True $ createCookieJar []
  where set_cookie = default_set_cookie {setCookieExpires = Just default_time}

testReceiveSetCookieSecure :: Test
testReceiveSetCookieSecure = TestCase $ assertBool "Secure flag gets set correctly" $
  cookie_secure_only $ head $ destroyCookieJar $ receiveSetCookie set_cookie default_request default_time True $ createCookieJar []
  where set_cookie = default_set_cookie {setCookieSecure = True}

testReceiveSetCookieMaxAge :: Test
testReceiveSetCookieMaxAge = TestCase $ assertEqual "Max-Age gets set correctly"
  total (cookie_expiry_time $ head $ destroyCookieJar $ receiveSetCookie set_cookie default_request now True $ createCookieJar [])
  where set_cookie = default_set_cookie { setCookieExpires = Nothing
                                        , setCookieMaxAge = Just $ secondsToDiffTime 10
                                        }
        now = UTCTime (ModifiedJulianDay 10) (secondsToDiffTime 12)
        total = UTCTime (ModifiedJulianDay 10) (secondsToDiffTime 22)

testReceiveSetCookiePreferMaxAge :: Test
testReceiveSetCookiePreferMaxAge = TestCase $ assertEqual "Max-Age is preferred over Expires"
  total (cookie_expiry_time $ head $ destroyCookieJar $ receiveSetCookie set_cookie default_request now True $ createCookieJar [])
  where set_cookie = default_set_cookie { setCookieExpires = Just exp
                                        , setCookieMaxAge = Just $ secondsToDiffTime 10
                                        }
        exp = UTCTime (ModifiedJulianDay 11) (secondsToDiffTime 5)
        now = UTCTime (ModifiedJulianDay 10) (secondsToDiffTime 12)
        total = UTCTime (ModifiedJulianDay 10) (secondsToDiffTime 22)

testReceiveSetCookieExisting :: Test
testReceiveSetCookieExisting = TestCase $ assertEqual "Existing cookie gets updated"
  t (cookie_expiry_time $ head $ destroyCookieJar $ receiveSetCookie set_cookie default_request default_time True $ createCookieJar [default_cookie])
  where set_cookie = default_set_cookie { setCookieExpires = Just t
                                        , setCookieMaxAge = Nothing
                                        }
        t = UTCTime (ModifiedJulianDay 10) (secondsToDiffTime 12)

testReceiveSetCookieExistingCreation :: Test
testReceiveSetCookieExistingCreation = TestCase $ assertEqual "Creation time gets updated in existing cookie"
  default_time (cookie_creation_time $ head $ destroyCookieJar $ receiveSetCookie default_set_cookie default_request now True $ createCookieJar [default_cookie])
  where now = UTCTime (ModifiedJulianDay 10) (secondsToDiffTime 12)

testReceiveSetCookieExistingHttpOnly :: Test
testReceiveSetCookieExistingHttpOnly = TestCase $ assertEqual "Existing http-only cookie gets dropped"
  default_time (cookie_expiry_time $ head $ destroyCookieJar $ receiveSetCookie default_set_cookie default_request default_time False $ createCookieJar [existing_cookie])
  where existing_cookie = default_cookie {cookie_http_only = True}

ipParseTests :: Specs
ipParseTests = do
    it "Valid IP" testValidIp
    it "Digit Too High" testIpNumTooHigh
    it "Too Many Segments" testTooManySegmentsInIp
    it "Chars in IP" testCharsInIp

domainMatchingTests :: Specs
domainMatchingTests = do
    it "Should Match" testDomainMatchesSuccess
    it "Same Domain" testSameDomain
    it "Sibling Domain" testSiblingDomain
    it "Parent Domain" testParentDomain
    it "Checking for Naive suffix-check" testNaiveSuffixDomain

defaultPathTests :: Specs
defaultPathTests = do
    it "Basic default path test" testDefaultPath
    it "Basic populated default path" testPopulatedDefaultPath
    it "Default path from request with GET params works" testParamsDefaultPath
    it "Getting a default path that ends in a slash" testDefaultPathEndingInSlash
    it "Getting a short default path" testShortDefaultPath

pathMatchingTests :: Specs
pathMatchingTests = do
    it "Same paths match" testSamePathsMatch
    it "Putting slash at end" testPathSlashAtEnd
    it "Not putting slash at end" testPathNoSlashAtEnd
    it "Diverging paths don't match" testDivergingPaths

equalityTests :: Specs
equalityTests = do
    it "The same cookie should be equal to itself" testCookieEqualitySuccess
    it "Changing extra options shouldn't change equality" testCookieEqualityResiliance
    it "Changing a cookie's domain should change its equality" testDomainChangesEquality

removeTests :: Specs
removeTests = do
    it "Removing a cookie works" testRemoveCookie
    it "Removing a nonexistant cookie doesn't work" testRemoveNonexistantCookie
    it "Removing the correct cookie" testRemoveCorrectCookie

evictionTests :: Specs
evictionTests = do
    it "Testing eviction" testEvictExpiredCookies
    it "Evicting from empty cookie jar" testEvictNoCookies

sendingTests :: Specs
sendingTests = do
    it "Updates last access time upon using cookies" testComputeCookieStringUpdateLastAccessTime
    it "Host-only flag matches exact host" testComputeCookieStringHostOnly
    it "Host-only flag doesn't match subdomain" testComputeCookieStringHostOnlyFilter
    it "Domain matching works properly" testComputeCookieStringDomainMatching
    it "Path matching works" testComputeCookieStringPathMatching
    it "Path matching fails when it should" testComputeCookieStringPathMatchingFails
    it "Path matching succeeds when request has GET params" testComputeCookieStringPathMatchingWithParms
    it "Secure flag filters correctly" testComputeCookieStringSecure
    it "Http-only flag filters correctly" testComputeCookieStringHttpOnly
    it "Sorting works correctly" testComputeCookieStringSort
    it "Inserting cookie header works" testInsertCookiesIntoRequestWorks

receivingTests :: Specs
receivingTests = do
    it "Can receive set-cookie" testReceiveSetCookie
    it "Receiving a Set-Cookie with a trailing dot on the domain" testReceiveSetCookieTrailingDot
    it "Receiving a Set-Cookie with a leading dot on the domain" testReceiveSetCookieLeadingDot
    it "Set-Cookie with no domain" testReceiveSetCookieNoDomain
    it "Set-Cookie with empty domain" testReceiveSetCookieEmptyDomain
    it "Set-Cookie with non-matching domain" testReceiveSetCookieNonMatchingDomain
    it "Host-only flag gets set" testReceiveSetCookieHostOnly
    it "Host-only flag doesn't get set" testReceiveSetCookieHostOnlyNotSet
    it "Http-only flag gets set" testReceiveSetCookieHttpOnly
    it "Http-only flag doesn't get set" testReceiveSetCookieHttpOnlyNotSet
    it "Checking non http request gets dropped" testReceiveSetCookieHttpOnlyDrop
    it "Name gets set correctly" testReceiveSetCookieName
    it "Value gets set correctly" testReceiveSetCookieValue
    it "Expiry gets set correctly" testReceiveSetCookieExpiry
    it "Expiry gets set based on max age if no expiry is given" testReceiveSetCookieNoExpiry
    it "Expiry gets set based on given value if no max age is given" testReceiveSetCookieNoMaxAge
    it "Expiry gets set to a future date if no expiry and no max age are given" testReceiveSetCookieNoExpiryNoMaxAge
    it "Path gets set correctly when nonexistant" testReceiveSetCookieNoPath
    it "Path gets set correctly" testReceiveSetCookiePath
    it "Creation time gets set correctly" testReceiveSetCookieCreationTime
    it "Last access time gets set correctly" testReceiveSetCookieAccessTime
    it "Persistent flag gets set correctly" testReceiveSetCookiePersistent
    it "Existing cookie gets updated" testReceiveSetCookieExisting
    it "Creation time gets updated in existing cookie" testReceiveSetCookieExistingCreation
    it "Existing http-only cookie gets dropped" testReceiveSetCookieExistingHttpOnly
    it "Secure flag gets set correctly" testReceiveSetCookieSecure
    it "Max-Age flag gets set correctly" testReceiveSetCookieMaxAge
    it "Max-Age is preferred over Expires" testReceiveSetCookiePreferMaxAge

cookieTest :: Specs
cookieTest = do
    describe "ipParseTests" ipParseTests
    describe "domainMatchingTests" domainMatchingTests
    describe "defaultPathTests" defaultPathTests
    describe "pathMatchingTests" pathMatchingTests
    describe "equalityTests" equalityTests
    describe "removeTests" removeTests
    describe "evictionTests" evictionTests
    describe "sendingTests" sendingTests
    describe "receivingTests" receivingTests
