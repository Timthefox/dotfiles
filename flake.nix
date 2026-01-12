{
  description = "Erste FlakeErfahrung seit Kellogs";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zenix = {
      url = "github:anders130/zenix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
      inputs.zen-browser.follows = "zen-browser";
    };
    nur.url = "github:nix-community/NUR";
    lsfg-vk-flake = {
      url = "github:pabloaul/lsfg-vk-flake/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    dotfiles-anders130.url = "github:anders130/dotfiles";
  };

  outputs = inputs @ {
    nixpkgs,
    home-manager,
    ...
  }: let
    mkHost = {
      username,
      modules ? [],
      system ? "x86_64-linux",
    }:
      nixpkgs.lib.nixosSystem {
        inherit system;
        modules =
          modules
          ++ [
            home-manager.nixosModules.home-manager
            inputs.lsfg-vk-flake.nixosModules.default
          ];
        specialArgs = {
          inherit inputs username;
        };
      };
  in {
    nixosConfigurations = {
      pc-stephan = mkHost {
        username = "stephan";
        modules = [
          ./hosts/pc-stephan/configuration.nix
        ];
      };
      laptop-musik = mkHost {
        username = "music";
        modules = [
          ./hosts/laptop-musik/configuration.nix
        ];
      };
    };
    overlays = import ./overlays.nix inputs;
  };
}
