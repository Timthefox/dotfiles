inputs: {
  default = inputs.nixpkgs.lib.composeManyExtensions [
    inputs.nur.overlays.default
    inputs.zenix.overlays.default
    (final: prev: {
      nautilus = prev.nautilus.overrideAttrs (nprev: {
        buildInputs =
          nprev.buildInputs
          ++ (with inputs.nixpkgs.legacyPackages.${prev.system}.gst_all_1; [
            gst-plugins-good
            gst-plugins-bad
            gst-plugins-ugly
          ]);
      });
    })
  ];
}
