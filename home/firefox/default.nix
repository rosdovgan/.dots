{ pkgs, user, ... }: {
  programs.firefox = {
    enable = true;
    profiles."${user.name}" = {
      isDefault = true;
      settings = {
      };
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        ublock-origin
       ];
    };
  };
}
