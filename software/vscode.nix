{
  inputs,
  unstable-pkgs,
  pkgs,
  username,
  ...
}: let
  extensions = (import inputs.nix-vscode-extensions).extensions.${pkgs.system}.vscode-marketplace;
in {
  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];

  environment.systemPackages = [
    (unstable-pkgs.vscode-with-extensions.override {
      vscodeExtensions = with extensions; [
        jnoortheen.nix-ide
        ms-python.python
      ];
    })
    pkgs.nixd
    pkgs.alejandra
    pkgs.python3
  ];

  home-manager.users.${username}.xdg.configFile."Code/User/settings.json".text = ''
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
               "expr": "(builtins.getFlake \"/home/stephan/.dotfiles\").nixosConfigurations.pc-stephan.options"
            },
          },
        }
      }
    }
  '';
}
