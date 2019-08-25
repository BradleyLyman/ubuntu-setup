import XMonad
import XMonad.Actions.Submap
import XMonad.Layout.Spacing
import XMonad.Layout.Decoration
import XMonad.Layout.NoFrillsDecoration
import XMonad.Layout.NoBorders
import XMonad.Util.EZConfig
import XMonad.Util.NamedScratchpad

import Data.List
import qualified Data.Map.Lazy as M
import qualified XMonad.StackSet as W

-- NOTE:
--   WM_CLASS(STRING) = "appName aka resource", "className"
-- ALSO:
--   If the window-finder doesn't work, then the ManageHook won't work
scratchpads =
    [ NS "htop" "alacritty -t htop -e htop" (title =? "htop") manageHTop
    , NS "mail" mailCmd (className =? "mail") manageEmail
    , NS "browse" browseCmd (className =? "browse-scratch") manageEmail
    , NS "chime" chimeCmd (className =? "chime-scratch") manageEmail
    , NS "elixir" "alacritty -t iex -e iex" (title =? "iex") manageElixir
    ]
    where
        manageHTop = customFloating $ W.RationalRect x y w h
            where
                h = 0.5
                w = 0.3
                x = 0.95 - w
                y = 0.05
        mailCmd = myBrowser
                ++ " https://ballard.amazon.com"
                ++ " -P mail --class=mail"
                ++ " --new-window"
        manageEmail = customFloating $ W.RationalRect x y w h
            where
                h = 0.6
                w = 0.6
                x = (1-w)/2
                y = (1-h)/2
        browseCmd = myBrowser
                  ++ " -P browse-scratch"
                  ++ " --class='browse-scratch'"
                  ++ " --new-window"
        chimeCmd = myBrowser
                 ++ " https://app.chime.aws"
                 ++ " -P chime-scratch"
                 ++ " --class='chime-scratch'"
                 ++ " --new-window"
        manageElixir = customFloating $ W.RationalRect x y w h
            where
                h = 0.4
                w = 0.4
                x = 0.05
                y = 0.05

myKeymap = [ ("M-n", spawn myLauncher)
           , ("M-b", spawn (myBrowser ++ " -P browser --class=browser --new-window"))
           , ("M-<Backspace>", kill)
           , ("M-<Return>", spawn myTerminal)
           , ("M-m", windows W.swapMaster)
           , ("M-s", submap . M.fromList $
               [ ((0, xK_b), namedScratchpadAction scratchpads "browse")
               , ((0, xK_c), namedScratchpadAction scratchpads "chime")
               , ((0, xK_h), namedScratchpadAction scratchpads "htop")
               , ((0, xK_m), namedScratchpadAction scratchpads "mail")
               , ((0, xK_e), namedScratchpadAction scratchpads "elixir")
               ])
           ]

main = xmonad $ myConfig

myConfig =
    def { terminal = myTerminal
        , normalBorderColor = inactive
        , focusedBorderColor = active
        , layoutHook = myLayoutHook
        , modMask = myModMask
        , focusFollowsMouse = myFocusFollowsMouse
        , clickJustFocuses = myClickJustFocuses
        , borderWidth = myBorderWidth
        , startupHook = return () >> checkKeymap myConfig myKeymap
        , manageHook = myManageHook <+> manageHook def
        }
    `additionalKeysP`
    myKeymap

myTerminal = "alacritty"
myModMask = mod4Mask
myBorderWidth = 2
myFocusFollowsMouse = False
myClickJustFocuses = True
myLayoutHook = addTopBar $ spacing gap $ noBorders $ Tall 1 (3/100) (2/3)
myLauncher = "rofi -matching fuzzy -combi-modi window,run -show combi -modi combi"
myBrowser = "firefox "
myManageHook = composeAll
    [ title =? "tetra-creative" --> doFloat
    , className =? "Screenkey" --> doFloat
    , className =? "Unity" --> doFloat
    , namedScratchpadManageHook scratchpads
    ]

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
inactive = base03

-- sizes
gap    = 10
topbar = 10
border = 0
prompt = 20
status = 20

myFont = "-*-terminus-medium-*-*-*-*-160-*-*-*-*-*-*"
addTopBar = noFrillsDeco shrinkText topBarTheme

topBarTheme = def
    { fontName = myFont
    , activeColor = active
    , inactiveColor = base03
    , urgentColor = activeWarn
    , activeBorderColor = active
    , inactiveBorderColor = inactive
    , urgentBorderColor = activeWarn
    , activeTextColor = active
    , inactiveTextColor = inactive
    , urgentTextColor = yellow
    , decoHeight = 10
    }
