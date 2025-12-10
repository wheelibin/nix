{ pkgs, ... }:

{

  home.packages = with pkgs; [ colima ];

  home.file.".config/colima/default/colima.yaml".source = ../../dotfiles/colima/colima.yaml;

  # prevent colima from writing to the config file on startup
  programs.zsh = {
    enable = true;
    initContent = ''
      export COLIMA_SAVE_CONFIG=0
    '';
  };
}
