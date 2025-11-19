{ config, pkgs, pkgs-unstable, ... }:

{
  #### No X11, use Wayland only ####
  services.xserver.enable = false;

  #### Audio via PipeWire ####
  services.pulseaudio.enable = false;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  services.dbus.enable = true;

  #### Hyprland + Wayland tools ####
  programs.hyprland.enable = true;

  security.pam.services.hyprlock = {};

  environment.systemPackages = [
    pkgs.waybar
    pkgs.wofi
    pkgs.hyprpaper
    pkgs.hypridle
    pkgs.hyprlock
    pkgs.hyprpolkitagent
    pkgs.alacritty
    pkgs.grim
    pkgs.slurp
    pkgs.wl-clipboard
    pkgs.jq
    pkgs.brightnessctl
    pkgs.pamixer
    pkgs.pass
    pkgs.firefox
    pkgs.neovim
    pkgs.dropbox
    pkgs.mako
    pkgs.rofi
    pkgs.git
    pkgs.gnupg
    pkgs.gcc
    pkgs-unstable.sunsetr
  ];

  #### greetd → log into Hyprland ####
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
