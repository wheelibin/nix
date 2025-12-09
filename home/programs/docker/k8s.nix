{ config, pkgs, ... }:

{
  home.packages = with pkgs; [ kubectl tilt];
  programs.k9s = {
    enable = true;
  };

}
