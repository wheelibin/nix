{ pkgs, ... }:

{

  home.packages = with pkgs; [ colima ];

  home.file.".config/colima/default/colima.yaml".source = ./colima.yaml;

  # prevent colima from writing to the config file on startup
  home.sessionVariables = {
    COLIMA_SAVE_CONFIG = 0;
  };
}
