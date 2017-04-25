import XMonad
import XMonad.Layout.Spacing
import XMonad.Layout.NoFrillsDecoration

main = xmonad def
    { terminal = "urxvt"
    , layoutHook = myLayoutHook
    , focusFollowsMouse = myFocusFollowsMouse
    , clickJustFocuses = myClickJustFocuses
    , borderWidth = myBorderWidth
    }

myBorderWidth = 0
myFocusFollowsMouse = False
myClickJustFocuses = True
myLayoutHook = addTopBar $ spacing 4 $ Tall 1 (3/100) (1/2)

addTopBar = noFrillsDeco shrinkText topBarTheme

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

topBarTheme = def
    { fontName = "-*-terminus-medium-*-*-*-*-160-*-*-*-*-*-*"
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


