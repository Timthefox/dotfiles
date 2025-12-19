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
    ../../shared
    ../../software/standardProgramme.nix
    ../../software/vscode.nix
    ../../software/nh.nix
    ../../software/programme.nix
    ../../software/zenix.nix
    ../../software/plasma.nix
    ../../software/daw-ardour.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot = {
    enable = true;
    windows."windows-10".efiDeviceHandle = "HD0b65535a1"; 
  };
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

  system.stateVersion = "25.11";
  hm.home.stateVersion = "25.11";
}
