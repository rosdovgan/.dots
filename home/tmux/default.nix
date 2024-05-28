{
  pkgs,
  config,
  c,
  colors,
  ...
}: {
  xdg.configFile."tmuxinator".source = /${c}/tmuxinator;
  programs.tmux = {
    enable = true;
    mouse = true;
    shell = "${pkgs.zsh}/bin/zsh";
    keyMode = "vi";
    clock24 = true;
    extraConfig =
      builtins.readFile /${c}/tmux/tmux.conf
      + ''
        set -g pane-border-style 'fg=${colors.pureWhite}'
        set -g pane-active-border-style 'fg=${colors.darkBlue}'
        set -g status-style 'bg=${colors.darkBlue}'
      '';
    plugins = with pkgs.tmuxPlugins; [resurrect];
    tmuxinator.enable = true;
  };

  programs.fzf.tmux.enableShellIntegration = config.programs.fzf.enable;
}
