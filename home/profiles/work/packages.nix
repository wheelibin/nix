{ pkgs, ... }:

{
  home.packages = with pkgs; [
    bruno
    btop
    eza
    fd
    lazydocker
    lazygit
    ripgrep
  ];
}
