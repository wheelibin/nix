{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # packages
    mongosh
  ];
}
