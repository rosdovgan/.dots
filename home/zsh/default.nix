{
  pkgs,
  config,
  c,
  ...
}: {
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    enableCompletion = true;
    enableAutosuggestions = true;
    history = {
      size = 100000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
    initExtra = builtins.readFile /${c}/zsh/.zshrc;

    plugins = [
      {
        name = "zsh-vi-mode";
        src = pkgs.fetchFromGitHub {
          owner = "jeffreytse";
          repo = "zsh-vi-mode";
          rev = "v0.11.0";
          sha256 = "sha256-xbchXJTFWeABTwq6h4KWLh+EvydDrDzcY9AQVK65RS8=";
        };
      }
    ];
  };

  programs.fzf.enableZshIntegration = config.programs.fzf.enable;
}
