{
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "de";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "de";

  services.kanata = {
    enable = true;
    keyboards.default.config = ''
      (defsrc
          caps
      )
      (deflayer default
          esc
      )
    '';
  };

  users.users.stephan.extraGroups = ["input" "uinput"];
}
