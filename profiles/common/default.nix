{ config, ... }:

{
  imports = [
    ../../modules/ai/opencode.nix
    ../../modules/desktop/fonts.nix
    ../../modules/docker
    ../../modules/editors/neovim/neovim.nix
    ../../modules/git
    ../../modules/languages
    ../../modules/shell
    ../../modules/terminal/ghostty/ghostty.nix
    ../../modules/desktop/karabiner-elements.nix
    ../../modules/desktop/omniwm.nix
    ../../modules/desktop/wallpaper.nix
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
