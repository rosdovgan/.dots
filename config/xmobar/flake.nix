{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };
  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

      overlay = final: prev: {
        xmobar-config = final.callCabal2nix "xmobar-config" ./. { };
      };
      haskellPackages = pkgs.haskellPackages.extend overlay;
    in
    {
      packages.${system}.default = haskellPackages.xmobar-config;
      devShells.${system}.default = haskellPackages.shellFor {
        packages = p : [
          p.xmobar-config
        ];
        nativeBuildInputs = with pkgs; [ 
          cabal-install
          haskell-language-server
        ];
      };
    };
}

