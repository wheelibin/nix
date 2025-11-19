{ config, pkgs, ... }:

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

  environment.systemPackages = with pkgs; [
    waybar
    wofi
    hyprpaper
    hypridle
    hyprlock
    hyprpolkitagent
    alacritty
    grim
    slurp
    wl-clipboard
    jq
    brightnessctl
    pamixer
    pass
    firefox
    neovim
    dropbox
    mako
    rofi
    git
    gnupg
    gcc
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
