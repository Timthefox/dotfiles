{
  inputs,
  username,
  ...
}: {
  imports = [
    inputs.disko.nixosModules.disko
    ./hardware-configuration.nix
    ./nvidia.nix
    ./festplatten.nix
    ../../hardware/drucker.nix
    ../../hardware/tastatur.nix
    ../../hardware/sound.nix
    ../../software/kurzbefehle.nix
    ../../software/standardProgramme.nix
    ../../software/vscode.nix
    ../../software/nh.nix
    ../../software/programme.nix
    ../../software/zenix.nix
    ../../software/plasma.nix
    ../../software/daw-ardour.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "pc-stephan"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "de_DE.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${username} = {
    isNormalUser = true;
    description = "Stephan Gollub";
    extraGroups = ["networkmanager" "wheel"];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [inputs.self.outputs.overlays.default];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
      "pipe-operators"
    ];
    download-speed = 6250; # limit download speed to 50 Mbps
  };

  home-manager = {
    users.${username}.home.stateVersion = "25.11";
    useGlobalPkgs = true;
  };
}
