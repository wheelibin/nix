{ pkgs, ... }:

{

  imports = [
    ./lazygit.nix
  ];

  programs.git = {
    enable = true;
    # Add your git config here:
    # userName = "Your Name";
    # userEmail = "your.email@example.com";
  };

  home.packages = with pkgs; [
    git-lfs
  ];
}
