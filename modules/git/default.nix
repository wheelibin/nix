{ pkgs, ... }:

{
  imports = [
    ./lazygit.nix
  ];

  programs.git = {
    enable = true;
    settings = {
      include = {
        path = "~/.config/git/local.config";
      };
      pull.rebase = true;
    };
  };

  home.packages = with pkgs; [
    git-lfs
    gh
    git-filter-repo
  ];
}
