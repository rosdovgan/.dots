{colors, ...}: {
  services.flameshot = {
    enable = true;
    settings.General = with colors.cssHex; {
      uiColor = blackT10;
      contrastUiColor = white;

      showStartupLaunchMessage = false;
      disabledTrayIcon = true;
      autoCloseIdleDaemon = true;
      startupLaunch = false;
    };
  };
}
