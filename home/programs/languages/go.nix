{ pkgs, ... }:

{
  programs.go.enable = true;

  home.packages = with pkgs; [
    delve
    gci
    gofumpt
    gotools
    golangci-lint
    golines
    go-task
  ];
}
