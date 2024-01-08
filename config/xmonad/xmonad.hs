{-# LANGUAGE FlexibleContexts #-}
{-# OPTIONS_GHC -Wno-missing-signatures #-}

import Control.Monad (when)
import Data.Either (fromRight)
import Data.Ini (lookupValue, readIniFile)
import qualified Data.Map as M
import qualified Data.Text as T
import Graphics.X11.ExtraTypes.XF86
import System.Directory (XdgDirectory (..), getXdgDirectory)
import System.Environment (getArgs)
import System.FilePath ((</>))
import System.Info (arch, os)
import System.Posix.Process (executeFile)
import Text.Printf (printf)
import XMonad
import XMonad.Actions.CycleWS (nextWS, prevWS)
import XMonad.Hooks.EwmhDesktops (ewmh, ewmhFullscreen)
import XMonad.Hooks.FadeWindows
  ( fadeWindowsEventHook,
    fadeWindowsLogHook,
    isUnfocused,
    opaque,
    transparency,
  )
import XMonad.Hooks.ManageDocks
  ( ToggleStruts (..),
    avoidStruts,
    docks,
    manageDocks,
  )
import XMonad.Hooks.PerWindowKbdLayout (perWindowKbdLayout)
import XMonad.Hooks.SetWMName (setWMName)
import XMonad.Hooks.StatusBar (defToggleStrutsKey, statusBarProp, withEasySB)
import XMonad.Hooks.StatusBar.PP
import XMonad.Layout.ResizableThreeColumns (MirrorResize (..))
import XMonad.Layout.ToggleLayouts (ToggleLayout (..), toggleLayouts)
import qualified XMonad.StackSet as W
import XMonad.Util.ClickableWorkspaces (clickablePP)
import XMonad.Util.Hacks
  ( trayPaddingXmobarEventHook,
    trayerAboveXmobarEventHook,
  )
import XMonad.Util.Loggers (logTitles)
import XMonad.Util.Run (runInTerm)

main :: IO ()
main = do
  iniPath <- getXdgDirectory XdgConfig "user/user.ini"
  ini <- fromRight mempty <$> readIniFile iniPath
  let color k =
        T.unpack . fromRight (T.pack "#ff00ff") $
          lookupValue (T.pack "colors") (T.pack k) ini

  launch'
    . ewmhFullscreen
    . ewmh
    . docks
    . withEasySB (mySB color) defToggleStrutsKey
    $ myConfig
  where
    launch' c = getDirectories >>= launch c
    mySB color = statusBarProp xmobarStartCmd (clickablePP $ myXmobarPP color)
    xmobarStartCmd = "until pgrep wireplumber; do sleep 2; done && xmobar"

myConfig =
  def
    { terminal = "kitty",
      modMask = mod4Mask,
      keys = myKeys,
      mouseBindings = myMouseBindings,
      borderWidth = 0,
      focusFollowsMouse = False,
      layoutHook = myLayoutHook,
      manageHook = myManageHook,
      logHook = myLogHook,
      startupHook = setWMName "LG3D",
      handleEventHook =
        perWindowKbdLayout
          <> fadeWindowsEventHook
          <> trayerAboveXmobarEventHook
          <> trayPaddingXmobarEventHook
            (className =? "stalonetray")
            "_XMONAD_TRAYPAD"
    }

myKeys :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
myKeys conf@(XConfig {XMonad.modMask = mm}) =
  M.fromList $
    [ ((mm, xK_Return), spawn $ terminal conf),
      ((mm, xK_d), openDotfiles),
      ((mm, xK_p), spawn "rofi -show drun -show-icons"),
      ((mm .|. shiftMask, xK_p), spawn "rofi -show run -show-icons"),
      ((mm, xK_w), spawn "rofi -show window"),
      ((mm, xK_c), kill),
      ((mm .|. shiftMask, xK_space), sendMessage NextLayout),
      ((mm, xK_space), sendMessage ToggleLayout),
      ((mm, xK_n), refresh),
      ((mm, xK_Tab), windows W.focusDown),
      ((mm .|. shiftMask, xK_Tab), windows W.focusUp),
      ((mm, xK_h), windows W.focusDown),
      ((mm, xK_l), windows W.focusUp),
      -- , ((mm,               xK_m     ), windows W.focusMaster  )
      -- , ((mm,               xK_Return), windows W.swapMaster)
      ((mm .|. shiftMask, xK_h), windows W.swapDown),
      ((mm .|. shiftMask, xK_l), windows W.swapUp),
      ((mm, xK_j), sendMessage Shrink),
      ((mm, xK_k), sendMessage Expand),
      ((mm .|. shiftMask, xK_j), sendMessage MirrorShrink),
      ((mm .|. shiftMask, xK_k), sendMessage MirrorExpand),
      ((mm, xK_t), withFocused $ windows . W.sink),
      -- , ((modMasmmk,               xK_comma ), sendMessage (IncMasterN 1))
      -- , ((mm,               xK_period), sendMessage (IncMasterN (-1)))
      ((mm, xK_period), nextWS),
      ((mm, xK_comma), prevWS),
      ((mm, xK_q), restart "xmonad" True),
      ((mm, xK_r), compileRestart True),
      ((mm, xK_b), sendMessage ToggleStruts),
      ((mm, xK_m), toggleConky)
      -- ((mm, xK_m), allNamedScratchpadAction myScratchpads "conky")
    ]
      ++ [
           -- mod-[1..9] %! Switch to workspace N
           -- mod-shift-[1..9] %! Move client to workspace N
           ((m .|. mm, k), windows $ f i)
           | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9],
             (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]
         ]
      ++ [ ((0, xF86XK_MonBrightnessUp), brightnessUp),
           ((0, xF86XK_MonBrightnessDown), brightnessDown),
           ((0, xF86XK_AudioRaiseVolume), raiseVolume),
           ((0, xF86XK_AudioLowerVolume), lowerVolume),
           ((0, xF86XK_AudioMute), muteVolume),
           ((0, xF86XK_AudioPlay), audioPlay),
           ((0, xF86XK_AudioStop), audioStop),
           ((0, xF86XK_AudioNext), audioNext),
           ((0, xF86XK_AudioPrev), audioPrev),
           ((0, xF86XK_PowerOff), toggleBrightness),
           -- ((mm, xK_l), spawn "xdg-screensaver activate"),
           ((0, xK_Print), spawn "flameshot gui"),
           ((shiftMask, xK_Print), spawn "gpick -s")
         ]
  where
    getScriptPath x = getXdgDirectory XdgConfig ("user/scripts/" ++ x)
    openDotfiles = runInTerm "" "tmuxinator start dots"
    toggleConky = liftIO (getScriptPath "toggle-conky.sh") >>= spawn
    toggleBrightness = liftIO (getScriptPath "toggle-brightness.sh") >>= spawn

    compileRestart resume = do
      dirs <- asks directories
      whenX (recompile dirs True) $ do
        when resume writeStateToFile
        catchIO $ do
          args <- getArgs
          executeFile (cacheDir dirs </> compiledConfig) False args Nothing

    compiledConfig = printf "xmonad-%s-%s" arch os

    brightnessUp = spawn "brillo -A 25"
    brightnessDown = spawn "brillo -U 25"

    raiseVolume = spawn "pactl -- set-sink-volume 0 +10%"
    lowerVolume = spawn "pactl -- set-sink-volume 0 -10%"
    muteVolume = spawn "pactl set-sink-mute 0 toggle"

    audioPlay = spawn "playerctl play"
    audioStop = spawn "playerctl pause"
    audioNext = spawn "playerctl next"
    audioPrev = spawn "playerctl previous"

myMouseBindings :: XConfig Layout -> M.Map (KeyMask, Button) (Window -> X ())
myMouseBindings (XConfig {XMonad.modMask = mm}) =
  M.fromList
    [ ((mm, button1), toFloatAndMove),
      ((mm, button2), raiseAndFocus),
      ((mm, button3), resize),
      ((mm, button4), const nextWS),
      ((mm, button5), const prevWS)
    ]
  where
    toFloatAndMove w = focus w >> mouseMoveWindow w >> windows W.shiftMaster
    raiseAndFocus = windows . (W.shiftMaster .) . W.focusWindow
    resize w = focus w >> mouseResizeWindow w >> windows W.shiftMaster

myLayoutHook = toggleLayouts (avoidStruts Full) (avoidStruts $ tiled ||| Mirror tiled)
  where
    tiled = Tall nmaster delta ratio
    nmaster = 1
    ratio = 1 / 2
    delta = 3 / 100

myManageHook = manageDocks

myLogHook :: X ()
myLogHook = fadeWindowsLogHook myFadeHook
  where
    myFadeHook = composeAll [opaque, isUnfocused --> transparency 0.25]

myXmobarPP :: (String -> String) -> PP
myXmobarPP color =
  def
    { ppSep = "   ",
      ppTitleSanitize = xmobarStrip,
      ppCurrent = wrap " " "" . xmobarBorder "Bottom" selHex 2,
      ppHidden = white . wrap " " "",
      ppHiddenNoWindows = dis . wrap " " "",
      ppUrgent = err . wrap (warn "!") (warn "!"),
      ppOrder = order,
      ppExtras = [logTitles formatFocused formatUnfocused],
      ppRename = \t _ -> xmobarRaw t
    }
  where
    order [ws, l, _, wins] = [ws, l, wins]
    order _ = []

    formatFocused = sel . ppWindow
    formatUnfocused = dis . ppWindow

    ppWindow :: String -> String
    ppWindow = xmobarRaw . (\w -> if null w then "untitled" else w) . shorten 20

    white = xmobarColor (color "pureWhite") ""
    sel = xmobarColor selHex ""
    dis = xmobarColor (color "lightGray") ""
    warn = xmobarColor (color "lightYellow") ""
    err = xmobarColor (color "red") ""
    selHex = color "darkBlue"
