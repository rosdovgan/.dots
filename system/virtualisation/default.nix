{ pkgs, users, ... }: {
  environment.systemPackages = with pkgs; [ virtiofsd ];

  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  users.users."${users.main.name}" = {
    extraGroups = [ "libvirtd" ];
  };
}
