{ pkgs, ... }:

{

  home.packages = with pkgs; [
    delve
    go
    gci
    gofumpt
    gotools
    golangci-lint
    golines
    go-task
  ];

  programs.zsh = {
    enable = true;

    initContent = ''
      export GOPATH="$HOME/go"
      export GOBIN="$GOPATH/bin"
      export PATH="$GOBIN:$PATH"
    '';
  };
}
