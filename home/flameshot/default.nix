{ colors, ... }: {
  services.flameshot = {
    enable = true;
    settings.General = {
      uiColor = colors.black;
      contrastUiColor = colors.pureWhite;

      showStartupLaunchMessage = false;
      disabledTrayIcon = true;
      autoCloseIdleDaemon = true;
      startupLaunch = false;
    };
  };
}
