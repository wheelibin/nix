{ pkgs, ... }:

{

  home.packages = [
    pkgs.tmux
  ];

  home.file.".config/tmux/tmux.conf".source = ../../dotfiles/tmux/tmux.conf;
}
