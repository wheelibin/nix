{ pkgs, ... }:

{
  home.packages = with pkgs; [
    lazygit
    jellyfin-media-player
    legcord
    btop
    eza
    fd
    ripgrep
    pass
  ];
}
