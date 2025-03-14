inputs: {
  default = inputs.nixpkgs.lib.composeManyExtensions [
    inputs.nur.overlays.default
    inputs.zenix.overlays.default
  ];
}