{
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    open = false;
    nvidiaSettings = true;
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
}
