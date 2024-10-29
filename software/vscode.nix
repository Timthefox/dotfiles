{
  inputs,
  pkgs,
  ...
}: {
  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

  environment.systemPackages = with pkgs; [
    (vscode-with-extensions.override {
      vscodeExtensions = [
        ((import inputs.nix-vscode-extensions).extensions.${pkgs.system}.vscode-marketplace.jnoortheen.nix-ide)
      ];
    })
    nixd
  ];

  home-manager.users.stephan.xdg.configFile."Code/User/settings.json".text = ''
    {
      "git.autofetch": true,
      "git.confirmSync": false

      "nix.serverPath": "nixd",
      "nix.enableLanguageServer": true,
      "nix.serverSettings": {
        "nixd": {
          "formatting": {
            "command": [ "alejandra" ],
          },
          "options": {
            "nixos": {
               "expr": "(builtins.getFlake \"/home/stephan/.dotfiles\").nixosConfigurations.linuxrechner1.options"
            },
          },
        }
      }
    }
  '';
}