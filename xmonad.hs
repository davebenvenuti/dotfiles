-- Pretty good resources:
--   http://beginners-guide-to-xmonad.readthedocs.org/en/latest/configure_xmonadhs.html
--   https://wiki.haskell.org/Xmonad/Config_archive/John_Goerzen's_Configuration

import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO
import XMonad.Actions.CycleWS

myManagementHooks :: [ManageHook]
myManagementHooks = [
    resource =? "stalonetray" --> doIgnore
      ]

main = do
  xmproc <- spawnPipe "xmobar"
  
  xmonad $ defaultConfig
    { modMask = mod4Mask -- rebind mod to special
    , manageHook = manageDocks <+> manageHook defaultConfig <+> composeAll myManagementHooks
    , layoutHook = avoidStruts  $  layoutHook defaultConfig
    , logHook = dynamicLogWithPP xmobarPP
      { ppOutput = hPutStrLn xmproc
      , ppTitle = xmobarColor "green" "" . shorten 50
      }
    } `additionalKeys`
    [ ((mod1Mask .|. controlMask, xK_Right), nextWS)
    , ((mod1Mask .|. controlMask, xK_Left), prevWS)
    , ((mod1Mask .|. controlMask, xK_l), spawn "xscreensaver-command -lock; xset dpms force off")
    ]

