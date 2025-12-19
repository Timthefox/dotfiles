{
  inputs,
  pkgs,
  ...
}: {
  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];

  environment.systemPackages = with pkgs; [
    vscode
    nixd
    alejandra
    python3
  ];

  hm.xdg.configFile."Code/User/settings.json".text = ''
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
