{pkgs, ...}: {
  xsession.initExtra = let
    xsr = pkgs.xorg.xsetroot + /bin/xsetroot;
  in ''
    ${xsr} -cursor_name left_ptr
    telegram-desktop -startintray &
    # slack -u &
    # webcord -m &
  '';

  home.file.".xinitrc".text = ''
    exec ~/.xsession
  '';
}
