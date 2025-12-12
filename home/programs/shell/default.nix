{ pkgs, ... }:

{
  imports = [
    ./atuin.nix
    ./btop.nix
    ./eza.nix
    ./fd.nix
    # ./fnm.nix
    ./fzf.nix
    ./jq.nix
    ./lazydocker.nix
    ./ripgrep.nix
    ./starship.nix
    ./tmux.nix
    ./yazi.nix
    ./zsh.nix
  ];

  home.packages = with pkgs; [
    gnupg
  ];
}
