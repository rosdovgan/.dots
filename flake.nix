{
  description = "NixOS configuration";

  inputs = {
    # nixpkgs.url = "github:nixos/nixpkgs/release-23.11";
    # home-manager.url = "github:nix-community/home-manager/release-23.11";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nur.url = "github:nix-community/NUR";
  };

  outputs = { nixpkgs, home-manager, nur, ... }: 
  let
    users = {  
      main = { name = "owner"; description = "Owner"; };
    }; 
    env = import common/env.const.nix;
    colors = import common/colors.const.nix;
    fonts = import common/fonts.const.nix;
  in
  {
    nixosConfigurations = {
      main = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          { nixpkgs.overlays = [ nur.overlay ]; }
          ({ pkgs, ... }:
            let
              nur-no-pkgs = import nur {
                nurpkgs = import nixpkgs { system = "x86_64-linux"; };
              };
            in {
              imports = [ nur-no-pkgs.repos.iopq.modules.xraya  ];
              services.xraya.enable = true;
            })
          ./system/hardware-configuration.nix { 
            _module.args = { 
              r = /.; 
              c = ./config; 
              inherit users env colors fonts; 
            };
          }
          ./system/configuration.nix 
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users."${users.main.name}" = { 
              _module.args = { 
                r = /.; 
                c = ./config; 
                user = users.main; 
                inherit env colors fonts; 
              };
              imports = [ ./home/home.nix ];
            };
            # Optionally, use home-manager.extraSpecialArgs to pass
            # arguments to home.nix
          }
          ];
      };
    };
  };
}
