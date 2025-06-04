{
  description = "Erste FlakeErfahrung seit Kellogs";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    zenix = {
      url = "github:anders130/zenix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    nur.url = "github:nix-community/NUR";
  };

  outputs = inputs @ {
    nixpkgs,
    home-manager,
    ...
  }: {
    nixosConfigurations.linuxrechner1 = nixpkgs.lib.nixosSystem rec {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
      ];
      specialArgs = {
        inherit inputs;
        unstable-pkgs = import inputs.nixpkgs-unstable {
          inherit system;
          config.allowUnfree = true;
        };
        username = "stephan";
      };
    };
    overlays = import ./overlays.nix inputs;
  };
}
