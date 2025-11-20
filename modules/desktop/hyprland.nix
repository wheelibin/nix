{ pkgs, pkgs-unstable, ... }:

{
  imports = [
    ./common.nix
    ./fonts.nix
  ];

  services.xserver.enable = false;

  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  services.dbus.enable = true;

  programs.hyprland.enable = true;
  security.pam.services.hyprlock = {};

  environment.systemPackages = with pkgs; [
    waybar
    wofi
    rofi
    hyprpaper
    hypridle
    hyprlock
    hyprpolkitagent
    mako
    alacritty
    grim
    slurp
    wl-clipboard
    jq
    brightnessctl
    pamixer
    firefox
    dropbox
    git
    gnupg
    gcc
    pkgs-unstable.sunsetr
  ];

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.hyprland}/bin/Hyprland";
        user = "jon";
      };
    };
  };
}
