{
  pkgs,
  scripts,
  ...
}: {
  runtimeInputs = with pkgs; [
    brillo
  ];

  text =
    "brillo -U 25"
    + " && ${scripts.notify-brightness}";
}
