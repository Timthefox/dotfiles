{pkgs,...}:{
  environment.systemPackages = [pkgs.ardour];
  services.pipewire.jack.enable = true;
}