{ pkgs, ... }:

{
  imports = [
    ./atuin.nix
    ./btop.nix
    ./eza.nix
    ./fd.nix
    ./fzf.nix
    ./jq.nix
    ./lazydocker.nix
    ./ripgrep.nix
    ./starship/starship.nix
    ./tmux/tmux.nix
    ./yazi.nix
    ./zsh.nix
  ];

  home.packages = with pkgs; [
    gnupg
  ];
}
