{ config, ... }:

{
  programs.zsh = {
    enable = true;
    dotDir = config.home.homeDirectory;

    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
    };

    # moved from the hand-written ~/.zprofile, which HM now manages
    profileExtra = ''
      eval "$(/opt/homebrew/bin/brew shellenv)"

      # OrbStack: command-line tools and integration
      source ~/.orbstack/shell/init.zsh 2>/dev/null || :
    '';

    initContent = ''
      unset __HM_SESS_VARS_SOURCED
      . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
    '';
  };
}
