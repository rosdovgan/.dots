{...}: {
  # Prevents immediate waking up by a weird usb keyboard behavior
  # boot.initrd.services.udev.rules = builtins.concatStringsSep ", " [
  # services.udev.extraRules = builtins.concatStringsSep ", " [
  #   ''ACTION=="add"''
  #   ''SUBSYSTEM=="usb"''
  #   ''DRIVERS=="usb"''
  #   ''ATTRS{idProduct}=="05c0"''
  #   ''ATTRS{idVendor}=="c0f4"''
  #   ''ATTR{power/wakeup}="disabled"''
  # ];

  # boot.initrd.services.udev.rules = ''
  #   ACTION=="add", SUBSYSTEM=="usb", DRIVERS=="usb", ATTRS{idProduct}=="05c0", ATTRS{idVendor}=="c0f4", ATTR{power/wakeup}="disabled"
  # '';

    # ''ATTR{driver/1-4/power/wakeup}="disabled"''
    # ''ATTRS{power/wakeup}="disabled"''
  # Swap escape and capslock keys
  services.udev.extraHwdb = ''
    evdev:atkbd:*
      KEYBOARD_KEY_3a=esc
      KEYBOARD_KEY_01=capslock

    evdev:name:*usb*keyboard*:*
      KEYBOARD_KEY_70039=esc
      KEYBOARD_KEY_70029=capslock
  '';
}
