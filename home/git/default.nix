{...}: {
  home.shellAliases = {
    "ga" = "git add";
    "gs" = "git status";
    "gd" = "git diff";
  };

  programs.git = {
    enable = true;
    extraConfig = {
      init = {
        defaultBranch = "main";
      };

      core.askPass = "";
    };
  };
}
