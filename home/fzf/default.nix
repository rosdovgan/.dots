{pkgs, ...}: {
  programs.fzf = {
    enable = true;
    defaultCommand = "${pkgs.fd}/bin/fd --hidden";
  };
}
