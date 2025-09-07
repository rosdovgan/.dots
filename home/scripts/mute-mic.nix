{
  pkgs,
  scripts,
  ...
}: {
  runtimeInputs = with pkgs; [
    wireplumber
  ];

  text =
    "wpctl set-mute @DEFAULT_SOURCE@ toggle"
    + " && ${scripts.notify-mic-volume}";
}
