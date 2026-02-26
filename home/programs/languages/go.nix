{ pkgs, config, ... }:

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

  home.sessionVariables = {
    GOPATH = "${config.home.homeDirectory}/go";
    GOBIN = "${config.home.homeDirectory}/go/bin";
  };

  home.sessionPath = [
    "${config.home.homeDirectory}/go/bin"
  ];

}
