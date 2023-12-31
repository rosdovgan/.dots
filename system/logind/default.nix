{ ... }: {
  services.logind = {
    powerKey = "ignore";
    powerKeyLongPress = "ignore";
    lidSwitch = "ignore";
  };
}
