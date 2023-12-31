{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };
  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

      overlay = final: prev: {
        xmonad-config = final.callCabal2nix "xmonad-config" ./. { };
      };
      haskellPackages = pkgs.haskellPackages.extend overlay;
    in
    {
      packages.${system}.default = haskellPackages.xmonad-config;
      devShells.${system}.default = haskellPackages.shellFor {
        packages = p : [
          p.xmonad-config
        ];
        nativeBuildInputs = with pkgs; [ 
          cabal-install
          haskell-language-server
        ];
      };
    };
}

