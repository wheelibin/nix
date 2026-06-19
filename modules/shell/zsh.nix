{ config, ... }:

{
  programs.zsh = {
    enable = true;
    dotDir = config.home.homeDirectory;

    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
    };

    initContent = ''
      unset __HM_SESS_VARS_SOURCED
      . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
    '';
  };
}
