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
  # Gnome Hilfsprogramme ausblenden
  services.gnome.core-apps.enable = false;

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
  programs.kdeconnect.package = pkgs.gnomeExtensions.gsconnect;
}
