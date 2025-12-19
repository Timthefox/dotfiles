{
  config,
  inputs,
  pkgs,
  username,
  ...
}: {
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/home/${username}/.dotfiles";
  };
  environment = {
    systemPackages = [(inputs.dotfiles-anders130.packages.${pkgs.stdenv.hostPlatform.system}.rebuild.override {arguments = ["--impure"];})];
    variables.NIX_FLAKE_DEFAULT_HOST = config.networking.hostName;
  };
}
