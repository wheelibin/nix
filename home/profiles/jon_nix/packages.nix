{ pkgs, ... }:

{
  home.packages = with pkgs; [
    cargo
    cmatrix
    jellyfin-media-player
    legcord
    pass
  ];
}
