{ ... }:

{
  imports = [
    ../common
    ./packages.nix
    ../../modules/desktop/karabiner-elements.nix
    ../../modules/ai/claude.nix
  ];

  programs.zsh.shellAliases.hm = "home-manager switch --impure --flake ~/dev/nix#mac_home";
}
