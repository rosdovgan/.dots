{
  r,
  user,
  ...
}: {
  sops = {
    age.keyFile = "/home/${user.name}/.config/sops/age/keys.txt";
    defaultSopsFile = /${r}/secrets/default.yaml;
    defaultSopsFormat = "yaml";
    secrets.favorite-color = {};

    secrets.firefoxBookmarks = {
      format = "binary";
      sopsFile = /${r}/secrets/firefox-bookmarks.html;
      key = "";
    };
  };
}
