{ ... }: {
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
