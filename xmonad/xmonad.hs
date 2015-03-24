-- Pretty good resources:
--   http://beginners-guide-to-xmonad.readthedocs.org/en/latest/configure_xmonadhs.html
--   http://iaindunning.com/2013/experiences-with-xmonad-and-ubuntu-12.html
--   https://wiki.haskell.org/Xmonad/Config_archive/John_Goerzen's_Configuration
--   https://github.com/Emantor/configs/blob/master/xmonad/xmonad.hs
--   http://askubuntu.com/questions/403113/how-do-you-enable-tap-to-click-via-command-line-with-xmodmap

import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import Graphics.X11.ExtraTypes.XF86
import System.IO
import XMonad.Actions.CycleWS

myManagementHooks :: [ManageHook]
myManagementHooks = [
    resource =? "stalonetray" --> doIgnore
      ]

main = do
  xmproc <- spawnPipe "xmobar"

  spawn "~/.xmonad/startup"

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
    --, ((mod1Mask .|. controlMask, xK_l), spawn "cinnamon-screensaver-command -l && xset dpms force off")
    , ((mod1Mask .|. controlMask, xK_l), spawn "gnome-screensaver-command -l && xset dpms force off")
    --, ((mod1Mask .|. controlMask, xK_l), spawn "xscreensaver-command -lock && xset dpms force off")
    , ((0 , xF86XK_AudioLowerVolume), spawn "~/.xmonad-pulsevolume/pulse-volume.sh decrease")
    , ((0 , xF86XK_AudioRaiseVolume), spawn "~/.xmonad-pulsevolume/pulse-volume.sh increase")
    ]

