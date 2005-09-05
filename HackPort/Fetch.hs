module Fetch(downloadFile) where

import Network.HTTP (ConnError(..),Request(..),simpleHTTP
                    ,Response(..),RequestMethod(..))
import Network.URI (URI,uriPath,parseURI)
import Text.Regex (Regex,mkRegex,matchRegex)

filenameRegex :: Regex
filenameRegex = mkRegex "^.*?/([^/]*?)"

uriToFileName :: URI -> Maybe FilePath
uriToFileName uri = maybe Nothing (\x->Just (head x)) (matchRegex filenameRegex (uriPath uri))

downloadURI :: FilePath --where to put(directory)
            -> URI --where to get
            -> IO (Either ConnError FilePath)
downloadURI path uri = do
	case uriToFileName uri of
		Nothing -> return (Left (ErrorMisc ("URI doesn't contain a failname")))
		Just name -> do
			result <- simpleHTTP request
			case result of
				Left err -> return (Left err)
				Right rsp
					| rspCode rsp == (2,0,0) -> let respath=path++"/"++name in writeFile respath (rspBody rsp) >> return (Right respath)
					| otherwise -> return (Left (ErrorMisc ("Invalid HTTP code: " ++ show (rspCode rsp))))
	where
	request = Request
		{rqURI=uri
		,rqMethod=GET
		,rqHeaders=[]
		,rqBody=""}

downloadFile :: FilePath
             -> String
             -> IO (Either ConnError FilePath)
downloadFile path url = case parseURI url of
	Just parsed -> downloadURI path parsed
	Nothing -> return (Left (ErrorMisc ("Failed to parse url: " ++ show url)))
