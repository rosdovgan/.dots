{ user, ... }: {
  programs.thunderbird = { 
    enable = true; 
    profiles."${user.name}" = {
      isDefault = true;
      settings = {
        "privacy.donottrackheader.enabled" = true; 
        "general.smoothScroll" = false;
      };
    };
  };
}
