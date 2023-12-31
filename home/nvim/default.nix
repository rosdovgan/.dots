{ pkgs, c, ... }: {
  home.packages = with pkgs; [ 
    (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; }) 
  ];

  fonts.fontconfig.enable = true;

  xdg.configFile."nvim".source = /${c}/nvim;
  programs.neovim = { 
    enable = true;
    defaultEditor = true;
    extraPackages = with pkgs; [ 
      wget gcc zig unzip
      fd ripgrep tree-sitter 
      trash-cli
      lua-language-server
      nil
    ];
  };
}
