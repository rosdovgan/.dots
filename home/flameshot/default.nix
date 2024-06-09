{ colors, ... }: {
  services.flameshot = {
    enable = true;
    settings.General = {
      uiColor = colors.blackT10;
      contrastUiColor = colors.white;

      showStartupLaunchMessage = false;
      disabledTrayIcon = true;
      autoCloseIdleDaemon = true;
      startupLaunch = false;
    };
  };
}
