import XMonad
import XMonad.Actions.Submap
import XMonad.Layout.Spacing
import XMonad.Layout.Decoration
import XMonad.Layout.NoFrillsDecoration
import XMonad.Layout.ThreeColumns
import XMonad.Util.EZConfig
import XMonad.Util.NamedScratchpad

import qualified Data.Map.Lazy as M
import qualified XMonad.StackSet as W

scratchpads =
    [ NS "htop" "urxvt -e htop" (title =? "htop") manageHTop
    ]
    where
        manageHTop = customFloating $ W.RationalRect x y w h
            where
                h = 0.5
                w = 0.3
                x = 0.95 - w
                y = 0.05

main = xmonad $ myConfig

myKeymap = [ ("M-n", spawn myLauncher)
           , ("M-b", spawn myBrowser)
           , ("M-<Backspace>", kill)
           , ("M-<Return>", spawn myTerminal)
           , ("M-m", windows W.swapMaster)
           , ("M-s", submap . M.fromList $
               [ ((0,xK_b), spawn myBrowser)
               , ((0, xK_t), spawn myTerminal)
               , ((0, xK_h), namedScratchpadAction scratchpads "htop")
               ])
           ]

myConfig = defaultConfig
    { terminal = myTerminal
    , layoutHook = myLayoutHook
    , modMask = myModMask
    , focusFollowsMouse = myFocusFollowsMouse
    , clickJustFocuses = myClickJustFocuses
    , borderWidth = myBorderWidth
    , startupHook = return () >> checkKeymap myConfig myKeymap
    , manageHook = myManageHook <+> manageHook defaultConfig
    }
    `additionalKeysP`
    myKeymap

myTerminal = "urxvt"
myModMask = mod4Mask
myBorderWidth = 0
myFocusFollowsMouse = False
myClickJustFocuses = True
myLayoutHook = addTopBar $ spacing gap $ ThreeColMid 1 (3/100) (1/3)
myLauncher = "rofi -matching fuzzy -combi-modi window,run -show combi -modi combi"
myBrowser = "google-chrome"
myManageHook = composeAll
    [ title =? "tetra-creative" --> doFloat
    ]
    <+> namedScratchpadManageHook scratchpads

-- Theme Definition --

-- Colors (solarized colors bby) --

base03  = "#002b36"
base02  = "#073642"
base01  = "#586e75"
base00  = "#657b83"
base0   = "#839496"
base1   = "#93a1a1"
base2   = "#eee8d5"
base3   = "#fdf6e3"
yellow  = "#b58900"
orange  = "#cb4b16"
red     = "#dc322f"
magenta = "#d33682"
violet  = "#6c71c4"
blue    = "#268bd2"
cyan    = "#2aa198"
green   = "#859900"

active = blue
activeWarn = red

-- sizes
gap    = 10
topbar = 10
border = 0
prompt = 20
status = 20

myFont = "-*-terminus-medium-*-*-*-*-160-*-*-*-*-*-*"
addTopBar = noFrillsDeco shrinkText topBarTheme

topBarTheme = defaultTheme
    { fontName = myFont
    , activeColor = active
    , inactiveColor = base03
    , urgentColor = activeWarn
    , activeBorderColor = active
    , inactiveBorderColor = base03
    , urgentBorderColor = activeWarn
    , activeTextColor = active
    , inactiveTextColor = base03
    , urgentTextColor = yellow
    , decoHeight = 10
    }
