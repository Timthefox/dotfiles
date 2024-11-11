# hier werden Variablen definiert mit let und in
let
  mountOptions = [
    "users" # allows any user to mount and umount
    "nofail" # prevent system from failing if this drive doesn't mount
    "rw" # read-write
    "x-gvfs-show" # nautilus can see this drive
  ];
in {
  boot.supportedFilesystems = [
    "ext4"
    "btrfs"
    "exfat"
    "ntfs"
  ];
  # TODO: bei Einrichtung für weitere Rechner muss die festplatte angepasst werden
  fileSystems = {
    "/mnt/games" = {
      device = "/dev/disk/by-uuid/0a21bdfb-6a38-4639-9481-d6098e542a9a";
      fsType = "ext4";
      options = mountOptions ++ ["defaults" "exec"];
    };
    "/mnt/HDD_1TB" = {
      device = "/dev/disk/by-uuid/700A97090A96CB8A";
      fsType = "ntfs";
      options = mountOptions;
    };
    "/mnt/SSD_SanDisk_1TB" = {
      device = "/dev/disk/by-uuid/1E1C16581C162AF3";
      fsType = "ntfs";
      options = mountOptions;
    };
    "/mnt/Windows10" = {
      device = "/dev/disk/by-uuid/D2A2E9C9A2E9B1E1";
      fsType = "ntfs";
      options = mountOptions;
    };
  };
}
