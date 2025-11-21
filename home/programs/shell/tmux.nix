{ pkgs, ... }:

{

  home.packages = [ pkgs.tmux ];

  home.file.".config/tmux".source = ../../dotfiles/tmux;
}
