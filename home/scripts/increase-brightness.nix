{
  pkgs,
  scripts,
  ...
}: {
  runtimeInputs = with pkgs; [
    brillo
  ];

  text =
    "brillo -A 25"
    + " && ${scripts.notify-brightness}";
}
