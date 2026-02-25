{ ... }:

{
  imports = [
    ../common
    ./packages.nix
    ../../programs/desktop/karabiner-elements.nix
    ../../programs/ai/claude.nix
  ];

  programs.zsh.shellAliases.hm = "home-manager switch --impure --flake ~/dev/nix#jon_mac";
}
