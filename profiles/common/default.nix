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

  home.activation.setWallpaper = config.lib.dag.entryAfter [ "writeBoundary" ] ''
    /usr/bin/osascript -e 'tell application "System Events" to set picture of every desktop to "${../../wallpapers/4-akane.jpg}"'
  '';
}
