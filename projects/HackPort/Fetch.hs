module Fetch(downloadTarball,downloadFileVerify) where

import Prelude hiding (catch)

import Network.HTTP (ConnError(..),Request(..),simpleHTTP
                    ,Response(..),RequestMethod(..))
import Network.URI (URI,uriPath,parseURI)
import Text.Regex (Regex,mkRegex,matchRegex)
import System.GPG
import Control.Monad.Error
import System.Directory
import System.FilePath
import Data.Typeable

import Error
import Action

filenameRegex :: Regex
filenameRegex = mkRegex "^.*?/([^/]*?)"

uriToFileName :: URI -> Maybe FilePath
uriToFileName uri = maybe Nothing (\x->Just (head x)) (matchRegex filenameRegex (uriPath uri))

downloadURI :: FilePath		-- ^ a directory to store the file
            -> URI 		-- ^ the url
            -> HPAction FilePath	-- ^ the path of the downloaded file
downloadURI path uri = do
	fileName <- maybe (throwError $ InvalidTarballURL (show uri) "URL doesn't contain a filename") return (uriToFileName uri)
	httpResult <- liftIO $ simpleHTTP request
	Response {rspCode=code,rspBody=body,rspReason=reason} <- either (\x->throwError $ DownloadFailed (show uri) "Connection failed") return httpResult
	if code==(2,0,0) then (do
		let writePath=path </> fileName
		liftIO $ writeFile writePath body
		return writePath) else throwError $ DownloadFailed (show uri) ("Code "++show code++":"++reason)
	where
	request = Request
		{rqURI=uri
		,rqMethod=GET
		,rqHeaders=[]
		,rqBody=""}


downloadFileVerify ::
	FilePath ->		-- ^ the directory to store the files
	String ->		-- ^ the url of the tarball
	String ->		-- ^ the url of the signature
	HPAction (FilePath,FilePath)	-- ^ the tarballs and signatures path
downloadFileVerify path url sigurl = do
	tarballPath <- downloadTarball path url
	sigPath <- downloadSig path sigurl `catchError` (\x->liftIO (removeFile tarballPath) >> throwError x)
	verified <- liftIO $ verifyFile stdOptions tarballPath sigPath
	if verified then return (tarballPath,sigPath) else (do
		liftIO $ removeFile tarballPath
		liftIO $ removeFile sigPath
		throwError $ VerificationFailed url sigurl)

downloadTarball ::
	FilePath ->
	String ->
	HPAction FilePath
downloadTarball dir url = download dir url InvalidTarballURL

downloadSig ::
	FilePath ->
	String ->
	HPAction FilePath
downloadSig dir url = download dir url InvalidSignatureURL

download :: FilePath				-- ^ the folder to store the file in
	 -> String				-- ^ the url
	 -> (String -> String -> HackPortError)	-- ^ a function to construct an error
	 -> HPAction FilePath			-- ^ the resulting file's path
download dir url errFunc = do
	parsedURL <- maybe (throwError $ errFunc url "Parsing failed") return (parseURI url)
	downloadURI dir parsedURL
