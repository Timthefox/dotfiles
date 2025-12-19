{
  lib,
  username,
  ...
}: {
  imports = [
    (lib.modules.mkAliasOptionModule ["hm"] ["home-manager" "users" username])
  ];
  home-manager = {
    useGlobalPkgs = true;
    backupFileExtension = "hm-bak";
  };
}
