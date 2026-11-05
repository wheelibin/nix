{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # packages
    glab
    mongosh
    postgresql_18
  ];
}
