{
  pkgs,
  config,
  c,
  colors,
  ...
}: {
  xdg.configFile."tmuxp".source = /${c}/tmuxp;
  programs.tmux = {
    enable = true;
    mouse = true;
    shell = "${pkgs.zsh}/bin/zsh";
    keyMode = "vi";
    clock24 = true;
    extraConfig =
      builtins.readFile /${c}/tmux/tmux.conf
      + ''
        set -g pane-border-style 'fg=${colors.grayS15}'
        set -g pane-active-border-style 'fg=${colors.beige}'
        set -g status-style 'bg=${colors.beige} fg=${colors.black}'
      '';
    plugins = with pkgs.tmuxPlugins; [resurrect];
    tmuxp.enable = true;
  };

  programs.fzf.tmux.enableShellIntegration = config.programs.fzf.enable;
}
