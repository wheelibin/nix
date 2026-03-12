{ pkgs-unstable, ... }:

{
  home.packages = with pkgs-unstable; [
    awscli2
  ];
}
