{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    kubectl
    tilt
    kubernetes-helm
  ];
  programs.k9s = {
    enable = true;
  };

}
