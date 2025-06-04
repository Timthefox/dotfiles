{username, inputs, pkgs, ...}: {
  home-manager.users.${username} = {
    imports = [inputs.zenix.homeModules.default];
    programs.zenix = {
      enable = true;
      chrome = {
        enable = false;
      };
      nativeMessagingHosts.packages = [pkgs.vdhcoapp];
      profiles.default = {
        id = 0;
        isDefault = true;
        extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
          ublock-origin
          bitwarden
          darkreader
          github-file-icons
          istilldontcareaboutcookies
          return-youtube-dislikes
          video-downloadhelper
        ];
      };
    };
  };
}