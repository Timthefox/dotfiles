{
  pkgs,
  username,
  ...
}: {
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  environment.gnome.excludePackages = with pkgs; [
    #gnome-photos
    gnome-tour
    atomix # puzzle game
    cheese # webcam tool
    epiphany # web browser
    evince # document viewer
    geary # email reader
    gnome-characters
    #gnome-music
    #gnome-terminal
    hitori # sudoku game
    iagno # go game
    #nautilus
    #totem # video player
    tali # poker game
    snapshot #webcam, die zZ gar nicht vorhanden ist
  ];

  home-manager.users.${username} = {
    dconf.settings = {
      "org/gnome/desktop/interface" = {
        clock-show-seconds = true;
        clock-show-weekday = true;
        enable-hot-corners = false;
      };
      "org/gnome/shell".app-picker-layout = "[]"; # sort apps by name
      "org/gnome/mutter" = {
        edge-tiling = true;
        dynamic-workspaces = true;
        workspaces-only-on-primary = true;
      };
      "org/gnome/shell/app-switcher".current-workspace-only = false;
    };
    home.file = let
      autostartPrograms = with pkgs; [
        vesktop
        signal-desktop
      ];
    in
      builtins.listToAttrs (map
        (pkg: {
          name = ".config/autostart/" + pkg.pname + ".desktop";
          value =
            if pkg ? desktopItem
            then {
              text = pkg.desktopItem.text;
            }
            else {
              source = pkg + "/share/applications/" + pkg.pname + ".desktop";
            };
        })
        autostartPrograms);
  };
}
