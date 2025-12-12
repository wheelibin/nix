{ pkgs, ... }:

{

  home.packages = with pkgs; [
    python313
    black
    isort
    ruff
  ];

  programs.uv = {
    enable = true;
  };

}
