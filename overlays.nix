inputs: {
  default = inputs.nixpkgs.lib.composeManyExtensions [
    inputs.nur.overlays.default
    inputs.zenix.overlays.default
    (final: prev: let
      inherit (prev.stdenv.hostPlatform) system;
      unstable = import inputs.nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    in {
      nautilus = prev.nautilus.overrideAttrs (nprev: {
        buildInputs =
          nprev.buildInputs
          ++ (with inputs.nixpkgs.legacyPackages.${system}.gst_all_1; [
            gst-plugins-good
            gst-plugins-bad
            gst-plugins-ugly
          ]);
      });
      inherit (unstable) lutris;
    })
  ];
}
