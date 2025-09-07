{
  pkgs,
  scripts,
  ...
}: {
  runtimeInputs = with pkgs; [
    wireplumber
  ];

  text =
    "wpctl set-volume @DEFAULT_SOURCE@ 10%-"
    + " && ${scripts.notify-mic-volume}";
}
