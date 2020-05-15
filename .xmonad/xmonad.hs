import XMonad
import XMonad.Config.Desktop
import XMonad.Hooks.DynamicLog
import Data.Monoid
import System.Exit

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

myTerminal    = "st"
myBorderWidth = 2
myModMask     = mod4Mask

myWorkspaces = ["term","web","3","4","5","6","7","8","music"]

nord1 = "#3B4252"
nord9 = "#81A1C1"

myNormalBorderColor  = nord1
myFocusedBorderColor = nord9

myBar = "xmobar"
myPP = xmobarPP { ppCurrent = xmobarColor nord9 "" . wrap "<" ">" }
toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

main = xmonad =<< statusBar myBar myPP toggleStrutsKey defaults

defaults = desktopConfig {
        terminal           = myTerminal,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor
    }

