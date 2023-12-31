{ pkgs, ... }: {
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [ 
       vulkan-loader libglvnd gmp 
       stdenv.cc.cc zlib pulseaudio 
    ] ++ 
    (with xorg; [ 
      libX11 libXi libXrandr libXxf86vm libXcursor libXinerama libXext 
      ]);
}
