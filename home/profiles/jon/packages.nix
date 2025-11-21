{ pkgs, ... }:

{
  home.packages = with pkgs; [
    jellyfin-media-player
    legcord
    pass
  ];
}
