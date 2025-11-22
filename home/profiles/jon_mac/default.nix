{ config, ... }:

{
  imports = [
    ./packages.nix
    ../../programs/shell
    ../../programs/editors/neovim.nix
    ../../programs/git
  ];

  xdg.enable = true;
  home.username = builtins.getEnv "USER";
  home.homeDirectory = builtins.getEnv "HOME";
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;

  programs.ssh = {
    enable = true;

    # Private per-machine configuration files that are NOT in git
    includes = [ "${config.home.homeDirectory}/.ssh/config.extra" ];
  };

  programs.zsh = {
    enable = true;
    shellAliases.hm = "home-manager switch --impure --flake ~/dev/nix#jon_mac";
  };


}
