{ ... }:

{
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.powersave = false;

  services.openssh.enable = true;
  services.openssh.settings.PasswordAuthentication = true;
}
