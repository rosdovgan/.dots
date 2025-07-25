{ pkgs, users, ... }: {
  environment.systemPackages = with pkgs; [ virtiofsd ];

  virtualisation.libvirtd.enable = true;
  services.samba.enable = true;
  
  boot.kernelModules = [ "kvm-amd" "kvm-intel" ];

  # programs.virt-manager.enable = true;

  users.users."${users.owner.name}" = {
    extraGroups = [ "libvirtd" "qemu-libvirtd" "libvirtd" ];
  };
}
