{
  pkgs,
  scripts,
  ...
}: {
  runtimeInputs = with pkgs; [
    wireplumber
  ];

  text =
    "wpctl set-volume @DEFAULT_SINK@ 10%+"
    + " && ${scripts.notify-speaker-volume}";
}
