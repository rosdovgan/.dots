{pkgs, ...}: {
  services.ssh-agent.enable = true;

  programs.ssh = {
    enable = true;
  };

  home.shellAliases.sai = let
    sa = pkgs.openssh + /bin/ssh-add;
  in ''
    sh -c 'eval $(ssh-agent -s) && ${sa} ~/.ssh/id_ed25519'
  '';
}
