import Control.OldException(catchDyn,try)
import XMonad.Util.Run
import Control.Concurrent
import DBus
import DBus.Connection
import DBus.Message
import System.Cmd
import XMonad
import XMonad.Config.Gnome
import XMonad.Hooks.DynamicLog
import XMonad.Layout.Accordion
import XMonad.Layout.Grid
import XMonad.ManageHook
import XMonad.Prompt
import XMonad.Util.EZConfig


main = withConnection Session $ \ dbus -> do
  getWellKnownName dbus
  xmonad $ gnomeConfig { 
    terminal = "xterm",
    modMask = mod4Mask, -- set the mod key to the windows key
    logHook  = dynamicLogWithPP (myPrettyPrinter dbus)
  }


-- This retry is really awkward, but sometimes DBus won't let us get our
-- name unless we retry a couple times.
getWellKnownName :: Connection -> IO ()
getWellKnownName dbus = tryGetName `catchDyn` (\ (DBus.Error _ _) ->
                                                getWellKnownName dbus)
 where
  tryGetName = do
    namereq <- newMethodCall serviceDBus pathDBus interfaceDBus "RequestName"
    addArgs namereq [String "org.xmonad.Log", Word32 5]
    sendWithReplyAndBlock dbus namereq 0
    return ()


myPrettyPrinter :: Connection -> PP
myPrettyPrinter dbus = defaultPP {
    ppOutput  = outputThroughDBus dbus
  , ppTitle   = pangoColor "#003366" . shorten 50 . pangoSanitize
  , ppCurrent = pangoColor "#006666" . wrap "[" "]" . pangoSanitize
  , ppVisible = pangoColor "#663366" . wrap "(" ")" . pangoSanitize
  , ppHidden  = wrap " " " "
  , ppUrgent  = pangoColor "red"
  }

outputThroughDBus :: Connection -> String -> IO ()
outputThroughDBus dbus str = do
  let str' = "<span font=\"Terminus 9 Bold\">" ++ str ++ "</span>"
  msg <- newSignal "/org/xmonad/Log" "org.xmonad.Log" "Update"
  addArgs msg [String str']
  send dbus msg 0 `catchDyn` (\ (DBus.Error _ _ ) -> return 0)
  return ()


pangoColor :: String -> String -> String
pangoColor fg = wrap left right
 where
  left  = "<span foreground=\"" ++ fg ++ "\">"
  right = "</span>"

pangoSanitize :: String -> String
pangoSanitize = foldr sanitize ""
 where
  sanitize '>'  acc = "&gt;" ++ acc
  sanitize '<'  acc = "&lt;" ++ acc
  sanitize '\"' acc = "&quot;" ++ acc
  sanitize '&'  acc = "&amp;" ++ acc
  sanitize x    acc = x:acc

