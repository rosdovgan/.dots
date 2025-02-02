{
  r,
  user,
  ...
}: {
  sops = {
    age.keyFile = "/home/${user.name}/.config/sops/age/keys.txt";
    defaultSopsFile = /${r}/secret/default.yaml;
    defaultSopsFormat = "yaml";
    secrets.favorite-color = {};

    secrets.firefoxBookmarks = {
      format = "binary";
      sopsFile = /${r}/secret/firefox-bookmarks.html;
      key = "";
    };
  };
}
