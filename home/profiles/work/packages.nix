{ pkgs, ... }:

{
  home.packages = with pkgs; [
    bruno
    fnm
  ];
}
