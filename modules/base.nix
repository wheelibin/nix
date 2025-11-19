{ config, pkgs, ... }:

{
  imports = [
    ../hardware-configuration.nix
  ];

  nix.package = pkgs.nixVersions.latest;
  nixpkgs.config.allowUnfree = true;

  #### Nix / flakes ####
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  #### Boot loader ####
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  #### Hostname ####
  networking.hostName = "mbp";

  #### Networking ####
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.powersave = false;

  #### SSH ####
  services.openssh.enable = true;
  # If you enabled password auth, keep this:
  services.openssh.settings.PasswordAuthentication = true;

  # Make zsh an allowed login shell
  environment.shells = with pkgs; [ zsh ];

  #### MBP hardware / sensors / power ####
  hardware.enableRedistributableFirmware = true;
  boot.kernelModules = [ "applesmc" "coretemp" ];

  services.mbpfan.enable = true;
  powerManagement.enable = true;
  services.tlp.enable = true;
  boot.extraModprobeConfig = ''
    # Work around Broadcom suspend/resume issues
    options brcmfmac roamoff=1
  '';
  systemd.services.fix-wifi-resume = {
    description = "Reload WiFi module after resume";
    after = [ "network.target" "sleep.target" ];
    wantedBy = [ "sleep.target" ];

    serviceConfig.Type = "simple";
    serviceConfig.ExecStart = "${pkgs.kmod}/bin/modprobe -r brcmfmac";
    serviceConfig.ExecStartPost = "${pkgs.kmod}/bin/modprobe brcmfmac";
  };

  services.logind.lidSwitch = "suspend";
  services.logind.lidSwitchDocked = "ignore";
  services.logind.lidSwitchExternalPower = "suspend";
  #### 


  #### User ####
  users.users.jon = { 
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" "audio" ];
    shell = pkgs.zsh;
  };
  programs.zsh.enable = true;

  programs.gnupg.agent = {
    enable = true;
  };

  #### State version ####
  system.stateVersion = "25.05";
}
