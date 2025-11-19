{ config, pkgs, ... }:

{
  imports = [
    ../../modules/base.nix
    ../../modules/desktop-hyprland.nix
  ];
}
