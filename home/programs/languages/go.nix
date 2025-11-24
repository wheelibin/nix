{ pkgs, ... }:

{

  home.packages = [ pkgs.go ];

  programs.zsh = {
    enable = true;

    initContent = ''
      export GOPATH="$HOME/go"
      export GOBIN="$GOPATH/bin"
      export PATH="$GOBIN:$PATH"
    '';
  };
}
