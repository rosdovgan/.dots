{ pkgs, fonts, ... }: {
  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome.gnome-themes-extra;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    gtk2.extraConfig = ''
      gtk-application-prefer-dark-theme="true"
    #   gtk-icon-theme-name = "Adwaita"
    #   gtk-theme-name = "Adwaita"
    #   gtk-font-name = ${fonts.main12}
    '';
    gtk3.extraConfig = { 
      gtk-application-prefer-dark-theme = true;
    #   gtk-icon-theme-name = "Adwaita";
    #   gtk-theme-name = "Adwaita-Dark";
    #   gtk-font-name = constants.fonts.MAIN;
    };
    gtk4.extraConfig = { 
      gtk-application-prefer-dark-theme = true;
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface".color-scheme = "prefer-dark";
    # "org/gnome/desktop/interface".gtk-theme = "Adwaita"; 
    # "org/gnome/desktop/interface".icon-theme = "Adwaita";
  };
}
