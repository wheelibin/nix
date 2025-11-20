{ ... }:

{
  imports = [
    ./mbp.nix
    ./fans.nix
    ./wifi.nix
    ./power.nix
  ];

  hardware.enableRedistributableFirmware = true;
}
