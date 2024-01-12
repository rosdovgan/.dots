import Data.Either (fromRight)
import Data.Ini (lookupValue, readIniFile)
import Data.List (intercalate)
import qualified Data.Text as T
import System.Directory (XdgDirectory (..), getXdgDirectory)
import Xmobar hiding (name)

main :: IO ()
main = do
  iniPath <- getXdgDirectory XdgConfig "user/user.ini"
  ini <- fromRight mempty <$> readIniFile iniPath
  userScriptsDir <- getXdgDirectory XdgConfig "user/scripts/"
  let getValue section def key =
        T.unpack . fromRight (T.pack def) $
          lookupValue (T.pack section) (T.pack key) ini
      color = getValue "colors" "#ff00ff"
      fontStyle = getValue "fonts" "-misc-fixed-*-*-*-*-12-*-*-*-*-*-*-*"

  configFromArgs (config color fontStyle userScriptsDir) >>= xmobar

config :: (String -> String) -> (String -> String) -> FilePath -> Config
config color fontStyle userScriptsDir =
  defaultConfig
    { font = fontStyle "main12",
      additionalFonts =
        [ fontStyle "main12",
          fontStyle "main11",
          fontStyle "main10",
          fontStyle "main8",
          fontStyle "main16"
        ],
      bgColor = color "darkBlack",
      fgColor = color "pureWhite",
      overrideRedirect = True,
      lowerOnStart = True,
      position = TopHM 30 0 0 0 0,
      sepChar = [mySepChar],
      commands = myCommands color,
      template = myTemplate color userScriptsDir
    }

mySepChar :: Char
mySepChar = '§'

myTemplate :: (String -> String) -> FilePath -> String
myTemplate color userScriptsDir = "}" ++ left ++ "{" ++ right
  where
    left = intercalate "  " [lg]
    right =
      intercalate
        "  "
        [ sep,
          net,
          sep,
          cpu,
          memory,
          sep,
          battery,
          brightness,
          volume,
          sep,
          kb,
          sep,
          dt,
          powerBtn,
          tray
        ]
    lg = fn 2 $ tc "UnsafeXMonadLog"
    net = tc "dynnetwork"
    brightness =
      action (notifyBrightness "brillo -A 25") "4"
        . action (notifyBrightness "brillo -U 25") "5"
        . tc
        $ "bright"

    volume =
      action (notifyVolume "pactl -- set-sink-volume 0 +10%") "4"
        . action (notifyVolume "pactl -- set-sink-volume 0 -10%") "5"
        . action (notifyVolume "pactl set-sink-mute 0 toggle") "2"
        . action "pavucontrol" "1"
        . tc
        $ "alsa:default:Master"
    cpu = tc "cpu"
    -- cpuTemp = tc "multicoretemp"
    memory = tc "memory" -- ++ tc "swap"
    battery = tc "battery"
    kb = action "xkb-switch -n" "1" . fn 2 . tc $ "kbd"
    dt = tc "date"
    powerBtn =
      action "rofi -show power-menu -modi power-menu:rofi-power-menu" "1"
        . fn 5
        $ "\xf0425"
    tray = fc (color "lighterBlack") $ tc "_XMONAD_TRAYPAD"

    notifyVolume cmd =
      unwords
        [ cmd,
          "&&",
          userScriptsDir ++ "notify-sound-volume-level.sh"
        ]
    notifyBrightness cmd =
      unwords
        [ cmd,
          "&&",
          userScriptsDir ++ "notify-brightness-level.sh"
        ]

myCommands :: (String -> String) -> [Runnable]
myCommands color = Run UnsafeXMonadLog : monitors
  where
    monitors =
      [net, cpu, mem, battery, brightness, volume, kb, dt, tray]
    net =
      let u = fn 4 " Kb/s"
       in Run $
            DynNetwork
              [ "-t",
                fn 2 $ concat [recIcon ++ " <rx>", u, " ", tranIcon ++ " <tx>", u]
              ]
              refRate
    cpu = Run $ Cpu ["-t", fn 2 $ cpuIcon ++ " <total>" ++ fn 4 "%"] refRate
    -- cpuTemp = Run $ MultiCoreTemp ["-t", "<avg>°C | <avgpc>%",
    --   "-L", "60", "-H", "80",
    --   "-l", "green", "-n", "yellow", "-h", "red",
    --   "--", "--mintemp", "20", "--maxtemp", "100"
    --   ] refRate
    mem =
      Run $
        Memory
          [ "-t",
            fn 2 $ memIcon ++ " <used>/<total>" ++ fn 4 " Gb",
            "-d",
            "1",
            "--",
            "--scale",
            "1024"
          ]
          refRate
    -- swap = Run $ Swap [ "-t", fn 2 " <usedratio>" ++ fn 4 "%" ] refRateLow
    battery =
      Run $
        Battery
          [ "-t",
            fn 2 "<acstatus> <left>" ++ fn 4 "%",
            "--",
            "-o",
            ' ' : batIcon,
            "-O",
            ' ' : batIconChrg,
            "-i",
            ' ' : batIconChrg
          ]
          refRate
    brightness =
      Run $
        Brightness
          [ "-t",
            fn 2 $ brightIcon ++ " <percent>" ++ fn 4 "%",
            "--",
            "-D",
            "intel_backlight"
          ]
          refRateHigh
    volume =
      Run $
        Alsa
          "default"
          "Master"
          [ "-t",
            "<status>",
            "--",
            "--on",
            fn 2 $ volIcon ++ " <volume>" ++ fn 4 "%",
            "--onc",
            color "pureWhite",
            "--off",
            fc (color "red") . fn 2 $ volIconMute ++ " <volume>" ++ fn 4 "%",
            "--offc",
            color "red"
          ]
    kb = Run $ Kbd []
    dt =
      Run $
        Date
          ( concat
              [ (action "thunderbird -calendar" "1" . fn 2) "%a %y.%m.%d ",
                sep,
                (action "gnome-clocks" "1" . fc (color "darkBlue")) " %H:%M"
              ]
          )
          "date"
          refRate
    tray = Run $ XPropertyLog "_XMONAD_TRAYPAD"

    refRate = 10
    refRateHigh = 2
    -- refRateLow = 50
    tranIcon = fn 1 "\xf0552"
    recIcon = fn 1 "\xf01da"
    brightIcon = fn 1 "\xf00e0"
    volIcon = fn 1 "\xf028"
    volIconMute = fn 1 "\xf026"
    cpuIcon = fn 1 "\xf035b"
    memIcon = fn 1 "\xf4bc"
    batIcon = fn 1 "\xf0079"
    batIconChrg = fn 1 "\xf0084"

sep :: String
sep = ""

-- Less uncanny
fn :: Int -> String -> String
fn n s = concat ["<fn=", show n, ">", s, "</fn>"]

fc :: String -> String -> String
fc c s = concat ["<fc=", c, ">", s, "</fc>"]

tc :: String -> String
tc cmd = mySepChar : cmd ++ [mySepChar]

action :: String -> String -> String -> String
action actionCmd button monitor =
  concat
    [ "<action=`",
      actionCmd,
      "` button=",
      button,
      ">",
      monitor,
      "</action>"
    ]
