{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";
    nixd.url = "github:nix-community/nixd";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs @ {
    nixpkgs,
    home-manager,
    flake-parts,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      debug = true;
      systems = ["x86_64-linux"];

      flake = let
        users = {
          main = {
            name = "owner";
            description = "Owner";
          };
        };
        sharedArgs = {
          r = /.;
          c = ./config;
          env = import common/env.const.nix;
          colors = import common/colors.const.nix {lib = nixpkgs.lib;};
          fonts = import common/fonts.const.nix;
        };

        overlays = with inputs; [
          nur.overlay
          nixd.overlays.default
        ];
      in {
        devShells.x86_64-linux.default = let
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
        in
          pkgs.mkShell {
            packages = with pkgs; [
              nixd
              alejandra
            ];
          };

        nixosConfigurations.main = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            {
              nixpkgs.overlays = overlays;
              nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];
            }

            ./system/hardware-configuration.nix

            ./system/configuration.nix
            {
              _module.args = {inherit users;} // sharedArgs;
            }

            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users."${users.main.name}".imports = [./home/home.nix];
                extraSpecialArgs = {user = users.main;} // sharedArgs;
              };
            }
          ];
        };

        # This chunk exists only because nixd can't evaluate options
        # You should't use it
        homeConfigurations = {
          main = home-manager.lib.homeManagerConfiguration {
            pkgs = nixpkgs.legacyPackages.x86_64-linux // {inherit overlays;};
            extraSpecialArgs = {user = users.main;} // sharedArgs;
            modules = [./home/home.nix];
          };
        };
      };
    };
}
