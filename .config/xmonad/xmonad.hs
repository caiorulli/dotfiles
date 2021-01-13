import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Actions.NoBorders
import XMonad.Actions.GridSelect
import XMonad.Util.EZConfig
import XMonad.Util.SpawnOnce
import Data.Monoid
import System.Exit

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

myTerminal :: String
myTerminal = "alacritty"

myBrowser :: String
myBrowser = "brave"

myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

myClickJustFocuses :: Bool
myClickJustFocuses = False

myBorderWidth :: Dimension
myBorderWidth = 2

myModMask :: KeyMask
myModMask = mod4Mask

myWorkspaces :: [String]
myWorkspaces = ["term","web","emacs","disc","etc","mail","steam","game","music"]

nord :: [String]
nord = [ "#2E3440"
       , "#3B4252"
       , "#434C5E"
       , "#4C566A"
       , "#D8DEE9"
       , "#E5E9F0"
       , "#ECEFF4"
       , "#8FBCBB"
       , "#88C0D0"
       , "#81A1C1"
       , "#5E81AC"
       , "#BF616A"
       , "#D08770"
       , "#EBCB8B"
       , "#A3BE8C"
       , "#B48EAD"
       ]

myNormalBorderColor :: String
myNormalBorderColor  = nord !! 1

myFocusedBorderColor :: String
myFocusedBorderColor = nord !! 9

myKeys :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
myKeys conf@XConfig {XMonad.modMask = modm} = M.fromList $

    [ ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)
    , ((modm,               xK_p     ), spawn "rofi -show run")
    , ((modm .|. shiftMask, xK_p     ), spawn "passmenu")
    , ((modm .|. shiftMask, xK_c     ), kill)
    , ((modm,               xK_space ), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ((modm,               xK_n     ), refresh)

    , ((modm,               xK_Tab   ), windows W.focusDown)
    , ((modm,               xK_j     ), windows W.focusDown)
    , ((modm,               xK_k     ), windows W.focusUp  )
    , ((modm,               xK_m     ), windows W.focusMaster  )
    , ((modm,               xK_Return), windows W.swapMaster)
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )

    , ((modm,               xK_h     ), sendMessage Shrink)
    , ((modm,               xK_l     ), sendMessage Expand)

    -- Push window back into tiling
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)
    , ((modm,               xK_g     ), withFocused toggleBorder)

    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))
    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))

    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    --
    -- , ((modm              , xK_b     ), sendMessage ToggleStruts)

    , ((modm .|. shiftMask, xK_q     ), io exitSuccess)
    , ((modm              , xK_q     ), spawn "xmonad --recompile; xmonad --restart")

    -- Run xmessage with a summary of the default keybindings (useful for beginners)
    , ((modm .|. shiftMask, xK_slash ), spawn ("echo \"" ++ help ++ "\" | xmessage -file -"))
    ]
    ++

    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++

    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

myMouseBindings :: XConfig l -> M.Map (KeyMask, Button) (Window -> X ())
myMouseBindings XConfig {XMonad.modMask = modm} = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), \w -> focus w >> mouseMoveWindow w
                                      >> windows W.shiftMaster)

    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), \w -> focus w >> windows W.shiftMaster)

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), \w -> focus w >> mouseResizeWindow w
                                      >> windows W.shiftMaster)

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

------------------------------------------------------------------------
-- Layouts:

-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--
myLayout = tiled ||| Mirror tiled ||| Full
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 1/2

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100

------------------------------------------------------------------------
-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook :: Query (Endo WindowSet)
myManageHook = composeAll
    [ className =? "Gimp"         --> doFloat
    , className =? myBrowser      --> doShift ( myWorkspaces !! 1 )
    , className =? "emacs"        --> doShift ( myWorkspaces !! 2 )
    , className =? "discord"      --> doShift ( myWorkspaces !! 3 )
    , className =? "signal"       --> doShift ( myWorkspaces !! 4 )
    , className =? "Thunderbird"  --> doShift ( myWorkspaces !! 5 )
    , title     =? "Steam"        --> doShift ( myWorkspaces !! 6 )
    , title     =? "Friends List" --> doShift ( myWorkspaces !! 6 ) <+> doFloat
    , className =? "spotify"      --> doShift ( myWorkspaces !! 8 )]

------------------------------------------------------------------------
-- Event handling

-- * EwmhDesktops users should change this to ewmhDesktopsEventHook
--
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
myEventHook :: Event -> X All
myEventHook = fullscreenEventHook

------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
myLogHook :: X ()
myLogHook = return ()

------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
myStartupHook :: X ()
myStartupHook = do
  spawnOnce myBrowser
  spawnOnce "steam"
  spawnOnce "thunderbird"
  spawnOnce "xrandr --output HDMI-A-0 --set TearFree on"

keyboardGridSelect :: [(String, X())]
keyboardGridSelect =
  [ ("BR", spawn "setxkbmap br")
  , ("US", spawn "setxkbmap us -variant alt-intl")
  ]

monitorGridSelect :: [(String, X ())]
monitorGridSelect =
  [ ("Two monitors", spawn "xrandr --output HDMI1 --auto --right-of eDP1; ~/.fehbg")
  , ("One monitor", spawn "xrandr --output HDMI1 --off; ~/.fehbg")
  ]

myBar :: String
myBar = "xmobar"

myPP :: PP
myPP = xmobarPP { ppCurrent = xmobarColor (nord !! 9) "" . wrap "<" ">" }

toggleStrutsKey :: XConfig l -> (KeyMask, KeySym)
toggleStrutsKey XConfig {XMonad.modMask = modm} = (modm, xK_b)

main :: IO ()
main = xmonad =<< statusBar myBar myPP toggleStrutsKey xConfig

xConfig = ewmh $ def {
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        clickJustFocuses   = myClickJustFocuses,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

        keys               = myKeys,
        mouseBindings      = myMouseBindings,

        layoutHook         = myLayout,
        manageHook         = myManageHook,
        handleEventHook    = myEventHook,
        logHook            = myLogHook,
        startupHook        = myStartupHook
    }
           `additionalKeysP`
           [ ("M-<Escape>", spawn "~/.config/xmonad/lock.sh")
           , ("<Print>", spawn "maim | xclip -selection clipboard -t image/png")
           , ("S-<Print>", spawn "maim -s | xclip -selection clipboard -t image/png")
           , ("<XF86AudioMute>", spawn "pamixer -t")
           , ("<XF86AudioRaiseVolume>", spawn "pamixer -i 5")
           , ("<XF86AudioLowerVolume>", spawn "pamixer -d 5")
           , ("<XF86AudioPlay>", spawn "playerctl play-pause")
           , ("<XF86AudioStop>", spawn "playerctl stop")
           , ("<XF86AudioPrev>", spawn "playerctl previous")
           , ("<XF86AudioNext>", spawn "playerctl next")
           , ("M-C-w", spawn myBrowser)
           , ("M-C-e", spawn "emacs")
           , ("M-C-s", spawn "steam")
           , ("M-C-d", spawn "discord")
           , ("M-C-b", spawn "blueman-manager")
           , ("M-C-m", spawn "alacritty -e btm")
           , ("M-C-n", spawn "alacritty -e newsboat")
           , ("M-C-p", spawn "alacritty -e pulsemixer")
           , ("M-o", runSelectedAction def keyboardGridSelect)
           , ("M-x", runSelectedAction def monitorGridSelect)
           ]

-- | Finally, a copy of the default bindings in simple textual tabular format.
help :: String
help = unlines ["The modifier key is 'super'. Keybindings:",
    "",
    "-- launching and killing programs",
    "mod-Shift-Enter  Launch " ++ myTerminal,
    "mod-p            Launch dmenu",
    "mod-Shift-p      Launch passmenu",
    "mod-Shift-c      Close/kill the focused window",
    "mod-Space        Rotate through the available layout algorithms",
    "mod-Shift-Space  Reset the layouts on the current workSpace to default",
    "mod-n            Resize/refresh viewed windows to the correct size",
    "",
    "-- move focus up or down the window stack",
    "mod-Tab        Move focus to the next window",
    "mod-Shift-Tab  Move focus to the previous window",
    "mod-j          Move focus to the next window",
    "mod-k          Move focus to the previous window",
    "mod-m          Move focus to the master window",
    "",
    "-- modifying the window order",
    "mod-Return   Swap the focused window and the master window",
    "mod-Shift-j  Swap the focused window with the next window",
    "mod-Shift-k  Swap the focused window with the previous window",
    "",
    "-- resizing the master/slave ratio",
    "mod-h  Shrink the master area",
    "mod-l  Expand the master area",
    "",
    "-- floating layer support",
    "mod-t  Push window back into tiling; unfloat and re-tile it",
    "",
    "-- increase or decrease number of windows in the master area",
    "mod-comma  (mod-,)   Increment the number of windows in the master area",
    "mod-period (mod-.)   Deincrement the number of windows in the master area",
    "",
    "-- quit, or restart",
    "mod-Shift-q  Quit xmonad",
    "mod-q        Restart xmonad",
    "mod-[1..9]   Switch to workSpace N",
    "",
    "-- Workspaces & screens",
    "mod-Shift-[1..9]   Move client to workspace N",
    "mod-{w,e,r}        Switch to physical/Xinerama screens 1, 2, or 3",
    "mod-Shift-{w,e,r}  Move client to screen 1, 2, or 3",
    "",
    "-- Mouse bindings: default actions bound to mouse events",
    "mod-button1  Set the window to floating mode and move by dragging",
    "mod-button2  Raise the window to the top of the stack",
    "mod-button3  Set the window to floating mode and resize by dragging"]
