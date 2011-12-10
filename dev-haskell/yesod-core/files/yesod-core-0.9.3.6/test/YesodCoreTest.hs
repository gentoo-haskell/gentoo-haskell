module YesodCoreTest (specs) where 

import YesodCoreTest.CleanPath
import YesodCoreTest.Exceptions
import YesodCoreTest.Widget
import YesodCoreTest.Media
import YesodCoreTest.Links
import YesodCoreTest.NoOverloadedStrings
import YesodCoreTest.InternalRequest
import YesodCoreTest.ErrorHandling
-- YesodCoreTest.Cache is not in upstream repo
-- import YesodCoreTest.Cache

import Test.Hspec

specs :: [Specs]
specs = 
    [ cleanPathTest
    , exceptionsTest
    , widgetTest
    , mediaTest
    , linksTest
    , noOverloadedTest
    , internalRequestTest
    , errorHandlingTest
--  , cacheTest
    ]
