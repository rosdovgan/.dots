{ config, pkgs, ...}: {
  environment.shellAliases = {
    system-packages-list = 
      "nix-store --query --requisites /run/current-system";
  };
  environment.etc."system-packages-list".text = let
      packages = builtins.map (p: "${p.name}") config.environment.systemPackages;
      sortedUnique = builtins.sort builtins.lessThan (pkgs.lib.unique packages);
      formatted = builtins.concatStringsSep "\n" sortedUnique;
    in
    formatted;
}
