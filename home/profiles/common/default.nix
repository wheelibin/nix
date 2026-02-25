{ config, ... }:

{
  imports = [
    ../../programs/shell
    ../../programs/editors/neovim/neovim.nix
    ../../programs/terminal/ghostty/ghostty.nix
    ../../programs/git
    ../../programs/languages
    ../../programs/desktop/fonts.nix
  ];

  xdg.enable = true;
  home.username = builtins.getEnv "USER";
  home.homeDirectory = builtins.getEnv "HOME";
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    includes = [ "${config.home.homeDirectory}/.ssh/config.extra" ];
  };
}
