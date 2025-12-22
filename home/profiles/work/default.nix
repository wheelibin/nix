{ config, ... }:

{
  imports = [
    ./packages.nix
    ../../programs/shell
    ../../programs/docker
    ../../programs/editors/neovim.nix
    ../../programs/git
    ../../programs/desktop/bruno.nix
    ../../programs/languages
    ../../programs/desktop/fonts.nix
    ../../programs/terminal/ghostty.nix
    ../../programs/ai/claude.nix
  ];

  xdg.enable = true;
  home.username = builtins.getEnv "USER";
  home.homeDirectory = builtins.getEnv "HOME";
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;

  programs.zsh = {
    enable = true;
    shellAliases.hm = "home-manager switch --impure --flake ~/dev/nix#work";
  };

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    # Private per-machine configuration files that are NOT in git
    includes = [ "${config.home.homeDirectory}/.ssh/config.extra" ];
  };

}
