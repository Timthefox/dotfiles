{
  pkgs,
  lib,
  ...
}: {
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    # Hier werden die Programme hinzugefügt - systemweit
    bitwarden-desktop
    neovim
    git
    libreoffice
    thunderbird
    protonup-qt # easy ge-proton setup for steam
    lutris
    # discord
    vesktop
    prismlauncher #minecraft launcher
    jdk17
    jdk8
    pavucontrol
    obsidian
    gimp
    ghostty
    signal-desktop
    ffmpeg
    vlc
    # Programme, die installiert werden
    gnome-calculator
    baobab
    file-roller
    loupe
    nautilus
    nautilus-python
    decibels
    nextcloud-client
  ];
  environment.sessionVariables.NAUTILUS_4_EXTENSION_DIR = lib.mkForce "${pkgs.nautilus-python}/lib/nautilus/extensions-4";
  environment.pathsToLink = [
    "/share/nautilus-python/extensions"
  ];
  # Install firefox.
  programs.firefox = {
    enable = true;
    nativeMessagingHosts.packages = [pkgs.vdhcoapp];
  };
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    package = pkgs.steam.override {extraPkgs = pkgs: [pkgs.attr];};
  };
}
