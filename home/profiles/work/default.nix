{ config, pkgs, ... }:

{
  imports = [
    ./packages.nix
    ../../programs/shell
    ../../programs/editors/neovim.nix
    ../../programs/git
    ../../programs/desktop/bruno.nix
  ];

  home.username = builtins.getEnv "USER";
  home.homeDirectory = builtins.getEnv "HOME";
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;

  programs.zsh = {
    enable = true;
    shellAliases.hm = "home-manager switch --impure --flake ~/dev/nix#work";
  };

}
