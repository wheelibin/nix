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

  programs.zsh = {
    enable = true;

    initContent = ''
      export GOPATH="$HOME/go"
      export GOBIN="$GOPATH/bin"
      export PATH="$GOBIN:$PATH"
    '';
  };
}
