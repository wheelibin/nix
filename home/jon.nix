{ config, pkgs, ... }:

{
  home.username = "jon";
  home.homeDirectory = "/home/jon";

  programs.home-manager.enable = true;

  # User-level packages (things you'd previously install via chezmoi / brew)
  home.packages = with pkgs; [
    lazygit
    jellyfin-media-player
    legcord
  ];

  # Example: manage dotfiles via Nix instead of chezmoi
  # (adjust paths / add more as you migrate)
  # home.file.".zshrc".source = ../dotfiles/zshrc;
  # home.file.".config/hypr/hyprland.conf".source = ../dotfiles/hyprland.conf;
  home.file.".config/waybar".source = ./dotfiles/waybar;
  home.file.".config/nvim".source = ./dotfiles/nvim;
  home.file.".config/starship.toml".source = ./dotfiles/starship.toml;
  home.file.".config/hypr".source = ./dotfiles/hypr;
  home.file.".config/alacritty".source = ./dotfiles/alacritty;

  # Example: enable eza/btop modules once you want their HM features
  programs.btop.enable = true;
  programs.eza.enable = true;
  programs.fd.enable = true;
  programs.ripgrep.enable = true;

  programs.starship = {
    enable = true;
    enableZshIntegration = true;  # since you’re on zsh
  };
  
  programs.zsh = {
    enable = true;

    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell"; # or "agnoster" etc
      plugins = [ ];
    };

    # Optional extra config appended to .zshrc
    initContent = ''
      # Fix TERM from Ghostty when SSH-ing
      if [[ "$TERM" = "xterm-ghostty" ]]; then
        export TERM="xterm-256color"
      fi
      export EDITOR="nvim"
      alias ll="eza -l"
      alias gs="git status"
      
      export ELECTRON_ENABLE_WAYLAND=1
    '';
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };


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

  home.stateVersion = "25.05";
}

