{ config, ... }:

{
  imports = [
    ./packages.nix
    ./services.nix
    ../../programs/shell
    ../../programs/editors/neovim.nix
    ../../programs/terminal/alacritty.nix
    ../../programs/desktop/hyprland.nix
    ../../programs/desktop/waybar.nix
    ../../programs/desktop/rofi.nix
    ../../programs/git
    ../../programs/languages/go.nix
  ];

  home.username = "jon";
  home.homeDirectory = "/home/jon";
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      "github.com" = {
        host = "github.com";
        identityFile = [ "${config.home.homeDirectory}/.ssh/id_ed25519" ];
        extraOptions = {
          AddKeysToAgent = "yes";
        };
      };
    };
  };

  programs.zsh = {
    enable = true;
    shellAliases.rb = "sudo nixos-rebuild switch --flake /etc/nixos#mbp";
    envExtra = ''
      ELECTRON_ENABLE_WAYLAND=1
    '';
    initContent = ''
      # Fix TERM from Ghostty when SSH-ing
      if [[ "$TERM" = "xterm-ghostty" ]]; then
        export TERM="xterm-256color"
      fi
      export EDITOR="nvim"
    '';
  };

}
