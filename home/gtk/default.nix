{
  pkgs,
  fonts,
  ...
}: {
  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    gtk2.extraConfig = ''
      gtk-application-prefer-dark-theme="true"
      # gtk-icon-theme-name = "Adwaita"
      # gtk-theme-name = "Adwaita"
      # gtk-font-name = ${fonts.main12}
    '';
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
      gtk-icon-theme-name = "Adwaita";
      gtk-theme-name = "Adwaita-dark";
      # gtk-font-name = constants.fonts.MAIN;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
      gtk-theme-name = "Default";
      gtk-icon-theme-name = "Default";
      "[AdwStyleManager]\ncolor-scheme" = "ADW_COLOR_SCHEME_PREFER_DARK";
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-theme = "Adwaita-dark";
    };
  };
}
