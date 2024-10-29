{pkgs, ...}: {
  #Drucker aktivieren:
  #Schritt 1: Netzwerkdrucker finden:
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
  #Schritt 2: Treiber für HP Drucker
  services.printing.drivers = [pkgs.hplipWithPlugin];
  # Enable CUPS to print documents.
  services.printing.enable = true;

  # scanner anstellen
  hardware.sane = {
    enable = true;
    extraBackends = [pkgs.hplipWithPlugin];
  };
}
