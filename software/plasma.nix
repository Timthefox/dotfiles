{
  inputs,
  pkgs,
  username,
  ...
}: {
  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  environment.systemPackages = with pkgs; [
    kdePackages.sddm-kcm
  ];
  home-manager.users.${username} = {
    imports = [inputs.plasma-manager.homeModules.plasma-manager];
    programs.plasma = {
      enable = true;
      workspace = {
        lookAndFeel = "org.kde.breezedark.desktop"; # dark mode
        cursor = {
          theme = "Bibata-Modern-Ice";
          size = 24;
        };
        iconTheme = "breeze-dark";
      };

      fonts = {
        general = {
          family = "JetBrains Mono";
          pointSize = 12;
        };
      };

      panels = [
        {
          location = "bottom";
          screen = "all";
          widgets = [
            {
              kickoff = {
                sortAlphabetically = true;
                icon = "nix-snowflake-white";
              };
            }
            {
              iconTasks = {
                launchers = [
                  "applications:org.kde.dolphin.desktop"
                  "applications:org.kde.konsole.desktop"
                  "applications:zen.desktop"
                ];
              };
            }
            "org.kde.plasma.marginsseparator"
            {
              systemTray.items = {
                shown = [
                  "org.kde.plasma.networkmanagement"
                  "org.kde.plasma.volume"
                ];
              };
            }
            {
              digitalClock = {
                calendar.firstDayOfWeek = "monday";
                time.format = "24h";
              };
            }
          ];
        }
      ];
    };
  };
}
