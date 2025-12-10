{ pkgs, ... }:

{

  home.packages = with pkgs; [ python313 ];

  programs.uv = {
    enable = true;
  };

}
