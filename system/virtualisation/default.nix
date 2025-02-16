{ pkgs, users, ... }: {
  environment.systemPackages = with pkgs; [ virtiofsd ];

  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  users.users."${users.owner.name}" = {
    extraGroups = [ "libvirtd" ];
  };
}
