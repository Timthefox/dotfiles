{
  inputs,
  pkgs,
  ...
}: let
  extensions = (import inputs.nix-vscode-extensions).extensions.${pkgs.system}.vscode-marketplace;
in {
  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

  environment.systemPackages = [
    (pkgs.vscode-with-extensions.override {
      vscodeExtensions = with extensions; [
        jnoortheen.nix-ide
      ];
    })
    pkgs.nixd
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