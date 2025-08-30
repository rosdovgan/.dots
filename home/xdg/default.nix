{
  pkgs,
  c,
  colors,
  fonts,
  ...
}: {
  xdg.configFile = {
    "floskell/config.json".source = /${c}/floskell/config.json;
    "user/user.ini".source = let
      inherit (colors) cssHex;
    in
      (pkgs.formats.ini {}).generate "user.ini" {
        colors = cssHex;
        inherit fonts;
      };
    "user/scripts".source = /${c}/user/scripts;
  };
}
