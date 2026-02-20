{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    kubectl
    kubectx
    tilt
    kubernetes-helm
  ];
  programs.k9s = {
    enable = true;
  };

}
