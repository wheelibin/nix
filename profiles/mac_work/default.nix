{ ... }:

{
  imports = [
    ../common
    ./packages.nix
    ../../modules/desktop/bruno.nix
    ../../modules/desktop/karabiner-elements.nix
    ../../modules/ai/opencode.nix
    ../../modules/cloud/aws.nix
  ];

  programs.zsh.shellAliases.hm = "home-manager switch --impure --flake ~/dev/nix#mac_work";
}
