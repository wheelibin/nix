{ config, pkgs, ... }:

{
  imports = [
    ./hardware.nix
    ../../modules/core
    ../../modules/desktop/hyprland.nix
    ../../modules/hardware/apple
  ];

  networking.hostName = "mbp";

  system.stateVersion = "25.05";
}
