{ pkgs, ... }:

{

  home.packages = with pkgs; [
    python313
    python313Packages.pip
    black
    isort
    ruff
  ];

  programs.uv = {
    enable = true;
  };

}
