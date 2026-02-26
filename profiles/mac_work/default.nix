{ ... }:

{
  imports = [
    ../common
    ./packages.nix
    ../../modules/docker
    ../../modules/desktop/bruno.nix
    ../../modules/desktop/karabiner-elements.nix
    ../../modules/ai/claude.nix
  ];

  programs.zsh.shellAliases.hm = "home-manager switch --impure --flake ~/dev/nix#mac_work";
}
