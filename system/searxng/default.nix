{...}: {
  services.searx = {
    enable = true;
    settings = {
      server = {
        port = 49152;
        bind_address = "localhost";
        secret_key = "";
      };
      search.autocomplete = "brave";
    };
  };
}
