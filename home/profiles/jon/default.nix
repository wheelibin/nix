{ config, pkgs, ... }:

{
  imports = [
    ./packages.nix
    ../../programs/shell
    ../../programs/editors/neovim.nix
    ../../programs/terminal/alacritty.nix
    ../../programs/desktop/hyprland.nix
    ../../programs/desktop/waybar.nix
    ../../programs/desktop/rofi.nix
    ../../programs/git
  ];

  home.username = "jon";
  home.homeDirectory = "/home/jon";
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;

  programs.ssh = {
    enable = true;
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
    shellAliases.rb = "rebuild command";
  };

  systemd.user.services.dropbox = {
    Unit = {
      Description = "Dropbox daemon";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = "${pkgs.dropbox}/bin/dropbox";
      Restart = "on-failure";
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
