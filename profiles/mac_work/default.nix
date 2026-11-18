{ ... }:

{
  imports = [
    ../common
    ./packages.nix
    ../../modules/desktop/bruno.nix
    ../../modules/cloud/aws.nix
  ];

  programs.zsh.shellAliases.hm = "home-manager switch --impure --flake ~/dev/nix#mac_work";

  wallpaper.file = "cats-anime.jpg"; # pin one from wallpapers/; unset = random (login + 06:00)
}
