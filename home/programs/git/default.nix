{ pkgs, ... }:

{
  imports = [
    ./lazygit.nix
  ];

  programs.git.enable = true;

  home.packages = with pkgs; [
    git-lfs
    gh
  ];
}
