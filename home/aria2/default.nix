{config, ...}: {
  xdg.stateFile."aria2/.keep".text = "";
  programs.aria2 = {
    enable = true;
    settings = let
      sessionFilePath = config.xdg.stateHome + "/aria2/aria2.session";
      homeDir = config.home.homeDirectory;
    in {
      dir = homeDir + "/Downloads";

      continue = true;
      save-session = sessionFilePath;
      save-session-interval = 60;

      max-concurrent-downloads = 3;
      max-connection-per-server = 4;
      split = 4;
      min-split-size = "1M";

      file-allocation = "falloc";

      max-overall-download-limit = 0;
      max-overall-upload-limit = 0;

      enable-rpc = false;
      rpc-listen-all = false;
      rpc-allow-origin-all = false;

      allow-overwrite = false;
      auto-save-interval = 60;

      seed-ratio = 10;
    };
  };
}
