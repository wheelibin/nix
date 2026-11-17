{
  pkgs,
  config,
  ...
}:

{

  programs.go = {
    enable = true;
    package = pkgs.go_1_27;
  };

  home.packages = with pkgs; [
    delve
    gci
    gofumpt
    golangci-lint
    golines
    go-task
    gotestsum # test runner for neotest-golang
    gotools # provides goimports (used by conform)
  ];

  home.sessionVariables = {
    GOPATH = "${config.home.homeDirectory}/go";
    GOBIN = "${config.home.homeDirectory}/go/bin";
  };

  home.sessionPath = [
    "${config.home.homeDirectory}/go/bin"
  ];

}
