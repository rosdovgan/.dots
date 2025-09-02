{...}: {
  # Prevents immediate waking up by a weird usb keyboard behavior
  services.udev.extraRules = builtins.concatStringsSep ", " [
    ''ACTION=="add"''
    ''SUBSYSTEM=="usb"''
    ''DRIVERS=="usb"''
    ''ATTRS{idVendor}=="c0f4"''
    ''ATTRS{idProduct}=="05c0"''
    ''ATTR{power/wakeup}="disabled"''
  ];

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
