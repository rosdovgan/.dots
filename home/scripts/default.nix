args @ {
  pkgs,
  lib,
  ...
}:
with lib; let
  scriptsDir = ./.;
  writeShellApplication' = name: x:
    pkgs.writeShellApplication (x // {inherit name;}) + "/bin/${name}";

  result = pipe (builtins.readDir scriptsDir) [
    (filterAttrs (x: _: x != "default.nix"))
    (mapAttrs (x: _: (import "${scriptsDir}/${x}") (args // { scripts = result;})))
    (mapAttrs' (x: y: nameValuePair (lib.removeSuffix ".nix" x) y))
    (mapAttrs writeShellApplication')
  ];
in result
