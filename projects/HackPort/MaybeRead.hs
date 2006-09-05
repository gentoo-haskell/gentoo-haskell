module MaybeRead where

import Data.List(find)
import Text.Read
import Text.ParserCombinators.ReadP

readMaybe :: Read a => String -> Maybe a
readMaybe = readsMaybe reads

readsMaybe :: ReadS a -> String -> Maybe a
readsMaybe func str = maybe Nothing (\x->Just (fst x)) (find (null.snd) (func str))

readPMaybe :: ReadP a -> String -> Maybe a
readPMaybe = readsMaybe.readP_to_S
