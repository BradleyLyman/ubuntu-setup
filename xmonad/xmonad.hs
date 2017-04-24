import XMonad
import XMonad.Layout.Spacing

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
myLayoutHook = spacing 4 $ Tall 1 (3/100) (1/2)
