{ config, c, ... }: {
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
  };
}
