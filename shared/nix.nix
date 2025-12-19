{inputs, ...}: {
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
      "pipe-operators"
    ];
    download-speed = 6250; # limit download speed to 50 Mbps
  };
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [inputs.self.outputs.overlays.default];
}
