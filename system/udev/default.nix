{...}: {
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
