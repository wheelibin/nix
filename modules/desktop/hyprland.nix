{ pkgs, pkgs-unstable, ... }:

let kenku-fm = pkgs.callPackage ../../pkgs/kenku-fm.nix { };
in {
  imports = [ ./common.nix ./fonts.nix ];

  services.xserver.enable = false;
  services.pulseaudio.enable = false;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  services.dbus.enable = true;
  programs.hyprland.enable = true;
  security.pam.services.hyprlock = { };

  environment.systemPackages = (with pkgs; [
    waybar
    wofi
    papirus-icon-theme
    hyprpaper
    hypridle
    hyprlock
    hyprpolkitagent
    mako
    nodejs_24
    grim
    slurp
    wl-clipboard
    brightnessctl
    pamixer
    git
    gnupg
    gcc
    pkgs-unstable.sunsetr
    firefox
    chromium
  ]) ++ [ kenku-fm ];

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
