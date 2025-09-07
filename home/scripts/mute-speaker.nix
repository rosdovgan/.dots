{
  pkgs,
  scripts,
  ...
}: {
  runtimeInputs = with pkgs; [
    wireplumber
  ];

  text =
    "wpctl set-mute @DEFAULT_SINK@ toggle"
    + " && ${scripts.notify-speaker-volume}";
}
