{ pkgs, ... }:

{

  home.packages = with pkgs; [
    nodejs_24
    eslint_d
    prettier
  ];

}
