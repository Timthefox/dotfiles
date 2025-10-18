{
  username, ...
}: {
  security.pam.sshAgentAuth.enable = true;
  nix.settings.trusted-users = [username];
  services.openssh.enable = true;
  security.sudo.extraRules = [
    {
      users = [username];
      commands = map (command: {
        inherit command;
        options = ["NOPASSWD"];
      }) [
        "/run/curren-system/sw/bin/env"
        "/run/curren-system/sw/bin/nix-env"
        "/run/curren-system/sw/bin/systemd-run"
        "/etc/profiles/per-user/${username}/bin/systemd-run"
      ];
    }
  ];
}