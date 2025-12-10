{ pkgs, ... }:

{

  home.packages = with pkgs; [ 
    python313
    black
    ruff
  ];

  programs.uv = {
    enable = true;
  };

}
