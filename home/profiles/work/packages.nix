{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # packages
    mongosh
    postgresql_18
  ];
}
