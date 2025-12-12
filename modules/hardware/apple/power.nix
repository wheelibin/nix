{ ... }:

{
  powerManagement.enable = true;
  services.tlp.enable = true;

  services.logind.settings.Login.HandleLidSwitch = "suspend";
  services.logind.settings.Login.HandleLidSwitchDocked = "ignore";
  services.logind.settings.Login.HandleLidSwitchExternalPower = "suspend";
}
