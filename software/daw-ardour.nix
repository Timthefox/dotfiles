{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    ardour
    qpwgraph
  ];
  services.pipewire.jack.enable = true;
}
