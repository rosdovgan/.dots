{ pkgs, lib, c, ... }: {
  home.packages = with pkgs; [ 
    (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; }) 
  ];

  fonts.fontconfig.enable = true;

  xdg.configFile = {
    "nvim/lua".source = /${c}/nvim/lua;
    "nvim/init.lua".source = /${c}/nvim/init.lua;
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    extraPackages = with pkgs; [
      wget gcc zig unzip
      fd ripgrep tree-sitter
      trash-cli
      nodejs
      nodePackages.bash-language-server
      lua-language-server
      nixd
      alejandra
    ];
  };
}
