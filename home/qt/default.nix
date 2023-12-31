{ pkgs, ... }: {
  qt = {
    enable = true;
    # style.name = "Adwaita-Dark";
    # platformTheme = "gtk";
    style.name = "kvantum";
    platformTheme = "qtct";
  };

  xdg.configFile = {
    "Kvantum/kvantum.kvconfig".source = 
      (pkgs.formats.ini {}).generate "kvantum.kvconfig" {
        General.theme = "KvGnomeDark";
      };
  };
}
