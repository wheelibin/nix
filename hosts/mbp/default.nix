{ ... }:

{
  imports = [
    ./hardware.nix
    ../../modules/core
    ../../modules/desktop/hyprland.nix
    ../../modules/hardware/apple
  ];

  networking.hostName = "mbp";
  nixpkgs.config.permittedInsecurePackages = [ "qtwebengine-5.15.19" ];
  system.stateVersion = "25.05";
}
