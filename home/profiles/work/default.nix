{ ... }:

{
  imports = [
    ../common/darwin.nix
    ./packages.nix
    ../../programs/docker
    ../../programs/desktop/bruno.nix
    ../../programs/desktop/karabiner-elements.nix
    ../../programs/ai/claude.nix
  ];

  programs.zsh.shellAliases.hm = "home-manager switch --impure --flake ~/dev/nix#work";
}
