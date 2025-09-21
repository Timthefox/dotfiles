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
    yt-dlp
    (pkgs.writers.writeFishBin "ytdl-playlist" {} ''
      if test (count $argv) -eq 0
          echo "Usage: ytdl-playlist <playlist_url> <mode>"
          echo "Mode options: video | audio"
          return 1
      end

      set playlist_url $argv[1]
      set mode $argv[2]

      if test "$mode" != "video" -a "$mode" != "audio"
          set mode "video"
      end

      if test "$mode" = "video"
          set ytdl_args -o "%(uploader)s/%(playlist)s/%(playlist_index)03d - %(title)s.%(ext)s" -f "bestvideo"
      else
          set ytdl_args -o "%(uploader)s/%(playlist)s/%(playlist_index)03d - %(title)s.%(ext)s" -f "bestaudio" -x
      end

      ${yt-dlp}/bin/yt-dlp $ytdl_args $playlist_url
    '')
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
  services.lsfg-vk = {
    enable = true;
    ui.enable = true; # installs gui for configuring lsfg-vk
  };
  programs.kdeconnect.enable = true;
}
