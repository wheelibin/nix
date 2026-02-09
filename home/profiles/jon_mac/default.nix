{ ... }:

{
  imports = [
    ../common/darwin.nix
    ./packages.nix
  ];

  programs.zsh.shellAliases.hm = "home-manager switch --impure --flake ~/dev/nix#jon_mac";
}
