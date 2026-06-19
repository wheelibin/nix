{
  pkgs,
  pkgs-unstable,
  config,
  ...
}:

{

  programs.go = {
    enable = true;
    package = pkgs-unstable.go;
  };

  home.packages =
    (with pkgs-unstable; [
      delve
      gofumpt
      golangci-lint
      golines
      go-task
      gotools # provides goimports (used by conform)
    ])
    ++ [ pkgs.gci ];

  home.sessionVariables = {
    GOPATH = "${config.home.homeDirectory}/go";
    GOBIN = "${config.home.homeDirectory}/go/bin";
  };

  home.sessionPath = [
    "${config.home.homeDirectory}/go/bin"
  ];

}
