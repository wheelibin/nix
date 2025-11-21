{ pkgs, ... }:

{
  home.packages = with pkgs; [
    bruno
    btop
    eza
    fd
    lazygit
    ripgrep
  ];
}
