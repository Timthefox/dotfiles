{
  inputs,
  pkgs,
  ...
}: let
  sddm-astronaut = pkgs.sddm-astronaut.override {
    themeConfig = {
      theme = "astronaut";
    };
  };
in {
  # Enable the KDE Plasma Desktop Environment.+
  services.displayManager.sddm = {
    enable = true;
    theme = "sddm-astronaut-theme";
    extraPackages = [sddm-astronaut];
  };
  services.desktopManager.plasma6.enable = true;
  environment.systemPackages = [sddm-astronaut];

  hm = {
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
